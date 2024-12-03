from Crypto.Cipher import AES
from Crypto.Util import Counter
from Crypto.Util.number import long_to_bytes, bytes_to_long

def int_to_bytes(val, length):
    """Convert an integer to a big-endian byte array of a specific length."""
    return val.to_bytes(length, byteorder='big')

def bytes_to_int(b):
    """Convert a big-endian byte array to an integer."""
    return int.from_bytes(b, byteorder='big')

def block_encrypt(key, v):
    """Encrypt the block using AES in ECB mode."""
    cipher = AES.new(key, AES.MODE_ECB)
    return cipher.encrypt(v)

def increment_counter(v, ctr_len, block_len):
    """Increment the counter based on ctr_len and block_len."""
    mod = 2 ** ctr_len
    rightmost_ctr = bytes_to_int(v[-(ctr_len // 8):])  # Extract the counter bits
    incremented = (rightmost_ctr + 1) % mod
    leftmost_part = v[:block_len - (ctr_len // 8)]
    incremented_bytes = int_to_bytes(incremented, ctr_len // 8)
    return leftmost_part + incremented_bytes

def CTR_DRBG_Update(provided_data, key, v, seed_len=384, key_len=256, block_len=128, ctr_len=124):
    """CTR DRBG Update process."""
    temp = b''

    # Loop until temp is seed_len bits (seed_len // 8 bytes)
    while len(temp) < seed_len // 8:
        if ctr_len < block_len:
            v = increment_counter(v, ctr_len, block_len // 8)
        else:
            v = (bytes_to_int(v) + 1) % (2 ** block_len)
            v = int_to_bytes(v, block_len // 8)
        
        # Encrypt V with Key
        output_block = block_encrypt(key, v)
        temp += output_block

    # Step 3: Take the leftmost seedlen bits
    temp = temp[:seed_len // 8]

    # Step 4: XOR temp with provided_data
    temp = bytes(a ^ b for a, b in zip(temp, provided_data))

    # Step 5: Extract Key and V from temp
    new_key = temp[:key_len // 8]
    new_v = temp[key_len // 8:key_len // 8 + block_len // 8]

    # Step 6: Return new Key and V
    return new_key, new_v


# Example usage
key = b'\x00' * 32  # 256-bit key (32 bytes)
v = b'\x00' * 16  # 128-bit block (16 bytes)
provided_data = b'\x01' * 48  # 384-bit provided data (48 bytes)

new_key, new_v = CTR_DRBG_Update(provided_data, key, v)

print("New Key:", new_key.hex())
print("New V:", new_v.hex())