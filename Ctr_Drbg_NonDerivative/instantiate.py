from update import Update, xor_bytes

def ctr_drbg_instantiate(entropy_input, nonce, personalization_string=None):
    """
    CTR_DRBG Instantiate Algorithm
    Args:
        entropy_input (bytes): Initial entropy input (32 bytes = 256 bits)
        nonce (bytes): Nonce value (16 bytes = 128 bits)
        personalization_string (bytes, optional): Personalization string (48 bytes or less)
    Returns:
        tuple: Initial working state (key, v, reseed_counter)
    """
    seedlen = Update.SEEDLEN  # 48 bytes = 384 bits

    # Step 1: Ensure entropy_input is correct length (32 bytes)
    if len(entropy_input) != 32:  # 256 bits
        raise ValueError(f"Entropy input must be 32 bytes (256 bits)")

    # Step 2: Ensure nonce is correct length (16 bytes)
    if len(nonce) != 16:  # 128 bits
        raise ValueError("Nonce must be 16 bytes (128 bits)")

    # Step 3: Process personalization string
    if personalization_string is None:
        personalization_string = bytes(seedlen)  # 48 bytes of zeros
    elif len(personalization_string) > seedlen:
        raise ValueError(f"Personalization string must not exceed {seedlen} bytes")
    else:
        # Pad personalization string with zeros if needed
        personalization_string = personalization_string + bytes(seedlen - len(personalization_string))

    # Step 4: seed_material = entropy_input || nonce || personalization_string
    seed_material = entropy_input + nonce  # 48 bytes total
    seed_material = xor_bytes(seed_material, personalization_string[:48])

    # Step 5: Set initial Key and V to zeros
    key = bytes(Update.KEYLEN)     # 32 bytes of zeros (256 bits)
    v = bytes(Update.BLOCKLEN)     # 16 bytes of zeros (128 bits)

    # Step 6: (Key, V) = Update (seed_material, Key, V)
    drbg = Update(key, v)
    key, v = drbg.update(seed_material)

    # Step 7: reseed_counter = 1
    reseed_counter = 1

    # Step 8: Return initial working state
    return (key, v, reseed_counter)

def test_instantiate():
    """
    Test the CTR_DRBG instantiation with test vectors
    """
    # Test vectors (correct lengths)
    entropy_input = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')  # 32 bytes
    nonce = bytes.fromhex('000102030405060708090A0B0C0D0E0F')  # 16 bytes
    personalization_string = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F') + bytes(16)  # 48 bytes

    print("Test Vectors:")
    print(f"Entropy Input ({len(entropy_input)} bytes): {entropy_input.hex()}")
    print(f"Nonce ({len(nonce)} bytes): {nonce.hex()}")
    print(f"Personalization String ({len(personalization_string)} bytes): {personalization_string.hex()}")

    try:
        # Perform instantiation
        key, v, reseed_counter = ctr_drbg_instantiate(
            entropy_input,
            nonce,
            personalization_string
        )

        print("\nResults:")
        print(f"Initial Key ({len(key)} bytes): {key.hex()}")
        print(f"Initial V ({len(v)} bytes): {v.hex()}")
        print(f"Initial Reseed Counter: {reseed_counter}")

    except ValueError as e:
        print(f"\nError: {e}")

if __name__ == "__main__":
    test_instantiate()