#!/bin/bash

# Parameters
KEY_TYPE="slh-dsa-44"           # You can change to slh-dsa-65 or slh-dsa-87 if supported
PRIVATE_KEY="slh_dsa_key.pem"
PUBLIC_KEY="slh_dsa_pub.pem"
INPUT_FILE="data.txt"
SIGNATURE_FILE="data.sig"

# Step 1: Generate SLH-DSA private key
openssl genpkey -algorithm "$KEY_TYPE" -out "$PRIVATE_KEY"
echo "[✔] Generated $KEY_TYPE private key: $PRIVATE_KEY"

# Step 2: Extract public key (optional, but useful)
openssl pkey -in "$PRIVATE_KEY" -pubout -out "$PUBLIC_KEY"
echo "[✔] Extracted public key: $PUBLIC_KEY"

# Step 3: Create example data to sign
echo "This is some data to be signed." > "$INPUT_FILE"

# Step 4: Sign the data
openssl pkeyutl -sign -inkey "$PRIVATE_KEY" -in "$INPUT_FILE" -out "$SIGNATURE_FILE"
echo "[✔] Signed file '$INPUT_FILE' -> Signature: $SIGNATURE_FILE"

# (Optional) Verify signature
openssl pkeyutl -verify -pubin -inkey "$PUBLIC_KEY" -in "$INPUT_FILE" -sigfile "$SIGNATURE_FILE" && \
echo "[✔] Signature successfully verified" || \
echo "[✘] Signature verification failed"
