import os
import struct
from Crypto.Cipher import AES

def xor_bytes(a: bytes, b: bytes) -> bytes:
    return bytes(x ^ y for x, y in zip(a, b))

class CTR_DRBG:
    BLOCKLEN = 16  # 128-bit AES block size
    KEYLEN = 32  # 256-bit AES key
    SEEDLEN = BLOCKLEN + KEYLEN  # 384-bit seed length

    def __init__(self, key: bytes, v: bytes):
        self.key = key
        self.v = v
        self.cipher = AES.new(self.key, AES.MODE_ECB)

    @staticmethod
    def block_encrypt(key: bytes, data: bytes) -> bytes:
        cipher = AES.new(key, AES.MODE_ECB)
        return cipher.encrypt(data)

    def update(self, provided_data: bytes):
        if len(provided_data) != self.SEEDLEN:
            raise ValueError("Provided data must be exactly seedlen bits.")

        temp = b""
        while len(temp) < self.SEEDLEN:
            self.v = (int.from_bytes(self.v, 'big') + 1) % (2 ** (self.BLOCKLEN * 8))
            self.v = self.v.to_bytes(self.BLOCKLEN, 'big')
            temp += self.block_encrypt(self.key, self.v)
        
        temp = temp[:self.SEEDLEN]
        temp = xor_bytes(temp, provided_data)
        
        self.key = temp[:self.KEYLEN]
        self.v = temp[self.KEYLEN:]
        
        return self.key, self.v

# Example Usage:
initial_key = os.urandom(32)  # Random 256-bit key
initial_v = os.urandom(16)    # Random 128-bit V
provided_data = os.urandom(48)  # Random seedlen (384-bit) provided data

# Print inputs
print("Initial Key:      ", initial_key.hex())
print("Initial V:        ", initial_v.hex())
print("Provided Data:    ", provided_data.hex())

drbg = CTR_DRBG(initial_key, initial_v)
new_key, new_v = drbg.update(provided_data)

# Print outputs
print("New Key:          ", new_key.hex())
print("New V:            ", new_v.hex())
