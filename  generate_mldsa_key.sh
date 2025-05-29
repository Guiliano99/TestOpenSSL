#!/bin/bash

# Set output file
KEY_OUT="mldsa-44-key.pem"

# Generate ML-DSA-44 key
openssl genpkey -algorithm mldsa-44 -out "$KEY_OUT"

echo "ML-DSA-44 private key written to $KEY_OUT"
