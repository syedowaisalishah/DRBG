from update import Update, xor_bytes

def ctr_drbg_reseed(working_state, entropy_input, additional_input=b''):
    """
    CTR_DRBG Reseed Algorithm
    Args:
        working_state (tuple): (key, v, reseed_counter)
        entropy_input (bytes): New entropy input (384 bits)
        additional_input (bytes): Optional additional input (384 bits or less)
    Returns:
        tuple: New working state (key, v, reseed_counter)
    """
    key, v, reseed_counter = working_state
    seedlen = Update.SEEDLEN  # 384 bits = 48 bytes

    # Step 1 & 2: Ensure additional_input is correct length
    if len(additional_input) < seedlen:
        additional_input = additional_input + b'\x00' * (seedlen - len(additional_input))

    # Step 3: seed_material = entropy_input ⊕ additional_input
    seed_material = xor_bytes(entropy_input, additional_input)

    # Step 4: (Key, V) = Update (seed_material, Key, V)
    drbg = Update(key, v)
    new_key, new_v = drbg.update(seed_material)

    # Step 5: reseed_counter = 1
    new_reseed_counter = 1

    # Step 6: Return new working state
    return (new_key, new_v, new_reseed_counter)

def test_reseed():
    # Initial working state
    key = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')
    v = bytes.fromhex('000102030405060708090A0B0C0D0E0F')
    reseed_counter = 0x10000000  # High value to trigger reseed

    # Test entropy input (384 bits = 48 bytes)
    entropy_input = bytes.fromhex('123456789ABCDEF0' * 6)
    
    # Optional additional input (zeros for this test)
    additional_input = bytes(48)  # 48 bytes of zeros

    print("Initial State:")
    print(f"Key: {key.hex()}")
    print(f"V: {v.hex()}")
    print(f"Reseed Counter: {reseed_counter}")
    print("\nInputs:")
    print(f"Entropy Input: {entropy_input.hex()}")
    print(f"Additional Input: {additional_input.hex()}")

    # Perform reseed
    new_key, new_v, new_reseed_counter = ctr_drbg_reseed(
        (key, v, reseed_counter),
        entropy_input,
        additional_input
    )

    print("\nAfter Reseed:")
    print(f"New Key: {new_key.hex()}")
    print(f"New V: {new_v.hex()}")
    print(f"New Reseed Counter: {new_reseed_counter}")

if __name__ == "__main__":
    test_reseed()