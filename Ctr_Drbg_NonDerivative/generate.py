from update import Update
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

class Generate:
    def __init__(self):
        self.KEYLEN = 32     # 256 bits = 32 bytes
        self.BLOCKLEN = 16   # 128 bits = 16 bytes
        self.SEEDLEN = self.KEYLEN + self.BLOCKLEN  # 48 bytes
        self.RESEED_INTERVAL = 1 << 48  # From NIST SP 800-90A
        
    def block_encrypt(self, key: bytes, data: bytes) -> bytes:
        """AES block encryption"""
        cipher = Cipher(algorithms.AES(key), modes.ECB())
        encryptor = cipher.encryptor()
        return encryptor.update(data) + encryptor.finalize()
    
    def generate(self, key: bytes, v: bytes, reseed_counter: int, 
                requested_bits: int, additional_input: bytes = b'') -> tuple:
        """CTR_DRBG_Generate_algorithm"""
        
        # 1. Check reseed counter
        if reseed_counter > self.RESEED_INTERVAL:
            return ("ERROR_FLAG", None, None, None, None)
            
        # 2. Process additional input
        if additional_input:
            # 2.1 & 2.2 Ensure additional_input is seedlen bits
            if len(additional_input) < self.SEEDLEN:
                additional_input = additional_input.ljust(self.SEEDLEN, b'\x00')
            # 2.3 Update with additional input
            updater = Update(key, v)  # Pass key and v to constructor
            key, v = updater.update(additional_input)
        else:
            additional_input = b'\x00' * self.SEEDLEN
            
        # 3. Initialize temp
        temp = b''
        
        # 4. Generate requested bits
        while len(temp) < (requested_bits + 7) // 8:  # Convert bits to bytes, rounding up
            # 4.1 Increment V
            v = (int.from_bytes(v, 'big') + 1) % (2 ** (self.BLOCKLEN * 8))
            v = v.to_bytes(self.BLOCKLEN, 'big')
            
            # 4.2 Generate block
            output_block = self.block_encrypt(key, v)
            
            # 4.3 Concatenate
            temp += output_block
            
        # 5. Extract requested bits
        returned_bits = temp[:(requested_bits + 7) // 8]
        
        # 6. Update for backtracking resistance
        updater = Update(key, v)  # Pass key and v to constructor
        key, v = updater.update(additional_input)
        
        # 7. Increment reseed_counter
        reseed_counter += 1
        
        # 8. Return results
        return ("SUCCESS", returned_bits, key, v, reseed_counter)

# Example usage
if __name__ == "__main__":
    # Initialize
    generator = Generate()
    
    # Test values
    key = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')
    v = bytes.fromhex('000102030405060708090A0B0C0D0E0F')
    reseed_counter = 1
    requested_bits = 256  # Request 256 bits (32 bytes) of random data
    additional_input = b"AdditionalInput123"  # Optional
    
    # Generate random bits
    status, random_bits, new_key, new_v, new_counter = generator.generate(
        key, v, reseed_counter, requested_bits, additional_input
    )
    
    # Print results
    print(f"Status: {status}")
    print(f"Random bits: {random_bits.hex()}")
    print(f"New Key: {new_key.hex()}")
    print(f"New V: {new_v.hex()}")
    print(f"New Counter: {new_counter}")