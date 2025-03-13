import os
import struct
from Crypto.Cipher import AES

def xor_bytes(a: bytes, b: bytes) -> bytes:
    """XOR two byte strings of equal length"""
    if len(a) != len(b):
        raise ValueError("Byte strings must be of equal length")
    return bytes(x ^ y for x, y in zip(a, b))

class Update:
    BLOCKLEN = 16  # 128-bit AES block size
    KEYLEN = 32    # 256-bit AES key
    SEEDLEN = BLOCKLEN + KEYLEN  # 384-bit seed length (48 bytes)

    def __init__(self, key: bytes, v: bytes):
        """Initialize with key and v values"""
        if len(key) != self.KEYLEN:
            raise ValueError(f"Key must be {self.KEYLEN} bytes")
        if len(v) != self.BLOCKLEN:
            raise ValueError(f"V must be {self.BLOCKLEN} bytes")
        self.key = key
        self.v = v
        self.cipher = AES.new(self.key, AES.MODE_ECB)

    @staticmethod
    def block_encrypt(key: bytes, data: bytes) -> bytes:
        """Encrypt a single block using AES-256 in ECB mode"""
        cipher = AES.new(key, AES.MODE_ECB)
        return cipher.encrypt(data)

    def update(self, provided_data: bytes):
        """
        Update function for CTR_DRBG
        Args:
            provided_data (bytes): Input data (must be SEEDLEN bytes)
        Returns:
            tuple: (new_key, new_v)
        """
        if len(provided_data) != self.SEEDLEN:
            raise ValueError(f"Provided data must be exactly {self.SEEDLEN} bytes")

        temp = b""
        # Step 1: temp = Null
        # Step 2: While len(temp) < seedlen
        while len(temp) < self.SEEDLEN:
            # Step 2.1: V = (V + 1) mod 2^128
            self.v = (int.from_bytes(self.v, 'big') + 1) % (2 ** (self.BLOCKLEN * 8))
            self.v = self.v.to_bytes(self.BLOCKLEN, 'big')
            # Step 2.2: temp = temp || AES-256(K, V)
            temp += self.block_encrypt(self.key, self.v)
        
        # Step 3: temp = leftmost(temp, seedlen)
        temp = temp[:self.SEEDLEN]
        
        # Step 4: temp = temp ⊕ provided_data
        temp = xor_bytes(temp, provided_data)
        
        # Step 5: K = leftmost(temp, keylen)
        self.key = temp[:self.KEYLEN]
        # Step 6: V = rightmost(temp, blocklen)
        self.v = temp[self.KEYLEN:]
        
        # Step 7: Return (K, V)
        return self.key, self.v

def test_update():
    """Test the Update function with test vectors"""
    # Test vectors
    key = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')
    v = bytes.fromhex('000102030405060708090A0B0C0D0E0F')
    provided_data = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F') + bytes(16)  # 48 bytes

    print("Test Vectors:")
    print(f"Initial Key ({len(key)} bytes): {key.hex()}")
    print(f"Initial V ({len(v)} bytes): {v.hex()}")
    print(f"Provided Data ({len(provided_data)} bytes): {provided_data.hex()}")

    try:
        # Create Update instance and perform update
        drbg = Update(key, v)
        new_key, new_v = drbg.update(provided_data)

        print("\nResults:")
        print(f"New Key ({len(new_key)} bytes): {new_key.hex()}")
        print(f"New V ({len(new_v)} bytes): {new_v.hex()}")

    except ValueError as e:
        print(f"\nError: {e}")

if __name__ == "__main__":
    test_update()