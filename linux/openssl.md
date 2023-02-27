
```bash
# Base64 转码
openssl base64 -in in.bin -out out.txt

# Base64 解码
openssl base64 -in in.txt -out out.bin

openssl dgst -md5 FILE 

openssl dgst -sha256 FILE 

# -blake2b512                -blake2s256                -md5                      
# -md5-sha1                  -ripemd                    -ripemd160                
# -rmd160                    -sha1                      -sha224                   
# -sha256                    -sha3-224                  -sha3-256                 
# -sha3-384                  -sha3-512                  -sha384                   
# -sha512                    -sha512-224                -sha512-256               
# -shake128                  -shake256                  -sm3                      
# -ssl3-md5                  -ssl3-sha1 
openssl dgst -list

```