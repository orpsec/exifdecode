#!/bin/bash

# Check the command-line parameter
if [[ "$1" != "-p" ]]; then
    echo "Invalid parameter! Usage: $0 -p file.jpg"
    exit 1
fi

# Get the file name
file="$2"

# Check the valid file extension
extension="${file##*.}"
if [[ ! "$extension" =~ ^(jpg|jpeg|png)$ ]]; then
    echo "Unsupported file extension! The file must be .jpg, .jpeg, or .png."
    exit 1
fi

# Use exiftool to extract the file's hashes
hashes=$(exiftool -s -s -s -md5 -sha1 -sha256 "$file")

# Print the hashes to console
echo "$hashes"

# Write the hashes to a file
echo "$hashes" > result.txt

# Prompt for decoding
read -p "Do you want to decode the hash? (y/n): " choice

# Decode the hash if requested
case $choice in
    [yY])
        read -p "Enter the decoding method (base64, rot13, md5, vigenere, sha256, rsa256): " method
        case $method in
            base64)
                decoded=$(echo "$hashes" | base64 --decode)
                echo "Decoded result: $decoded"
                echo "Decoded result: $decoded" >> result.txt
                ;;
            rot13)
                decoded=$(echo "$hashes" | tr 'A-Za-z' 'N-ZA-Mn-za-m')
                echo "Decoded result: $decoded"
                echo "Decoded result: $decoded" >> result.txt
                ;;
            md5)
                echo "Decoding with MD5 is not supported."
                ;;
            vigenere)
                echo "Decoding with Vigenère cipher is not supported."
                ;;
            sha256)
                echo "Decoding with SHA-256 is not supported."
                ;;
            rsa256)
                echo "Decoding with RSA-256 is not supported."
                ;;
            *)
                echo "Invalid decoding method!"
                ;;
        esac
        ;;
    [nN])
        exit 0
        ;;
    *)
        echo "Invalid choice!"
        exit 1
        ;;
esac