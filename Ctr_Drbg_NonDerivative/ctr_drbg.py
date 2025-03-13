from update import Update, xor_bytes

def ctr_drbg_generate(key, v, reseed_counter, requested_bytes, additional_input=None):
    """
    CTR_DRBG Generate Function
    Args:
        key (bytes): Current key (32 bytes)
        v (bytes): Current V value (16 bytes)
        reseed_counter (int): Current reseed counter
        requested_bytes (int): Number of bytes requested
        additional_input (bytes, optional): Additional input (48 bytes or less)
    Returns:
        tuple: (random_bits, new_key, new_v, new_reseed_counter)
    """
    seedlen = Update.SEEDLEN
    
    # Check reseed counter
    if reseed_counter > 2**48:
        raise ValueError("Reseed required")

    # Process additional input
    if additional_input is None:
        additional_input = bytes(seedlen)
    elif len(additional_input) > seedlen:
        raise ValueError(f"Additional input must not exceed {seedlen} bytes")
    else:
        additional_input = additional_input + bytes(seedlen - len(additional_input))

    # If additional_input is provided, update key and v
    if any(x != 0 for x in additional_input):
        drbg = Update(key, v)
        key, v = drbg.update(additional_input)

    # Generate random bits
    temp = b""
    drbg = Update(key, v)
    
    while len(temp) < requested_bytes:
        # Increment V
        v = (int.from_bytes(v, 'big') + 1) % (2 ** (Update.BLOCKLEN * 8))
        v = v.to_bytes(Update.BLOCKLEN, 'big')
        # Generate block
        temp += Update.block_encrypt(key, v)

    random_bits = temp[:requested_bytes]

    # Update state
    drbg = Update(key, v)
    key, v = drbg.update(additional_input)
    reseed_counter += 1

    return random_bits, key, v, reseed_counter

def test_generate():
    """Test the generate function"""
    # Test vectors
    key = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')
    v = bytes.fromhex('000102030405060708090A0B0C0D0E0F')
    reseed_counter = 1
    requested_bytes = 32
    additional_input = bytes(48)  # 48 bytes of zeros

    print("Test Vectors:")
    print(f"Initial Key: {key.hex()}")
    print(f"Initial V: {v.hex()}")
    print(f"Reseed Counter: {reseed_counter}")
    print(f"Requested Bytes: {requested_bytes}")
    print(f"Additional Input: {additional_input.hex()}")

    try:
        random_bits, new_key, new_v, new_reseed_counter = ctr_drbg_generate(
            key,
            v,
            reseed_counter,
            requested_bytes,
            additional_input
        )

        print("\nResults:")
        print(f"Random Bits: {random_bits.hex()}")
        print(f"New Key: {new_key.hex()}")
        print(f"New V: {new_v.hex()}")
        print(f"New Reseed Counter: {new_reseed_counter}")

    except ValueError as e:
        print(f"\nError: {e}")

if __name__ == "__main__":
    test_generate()