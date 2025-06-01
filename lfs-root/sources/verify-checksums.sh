#!/bin/bash

# Verify package checksums
set -e

cd $LFS/sources

echo "Verifying package checksums..."

# Check if md5sums file exists
if [ ! -f "md5sums" ]; then
    echo "Error: md5sums file not found"
    exit 1
fi

# Verify checksums
if md5sum -c md5sums; then
    echo "✓ All checksums verified successfully"
else
    echo "✗ Checksum verification failed"
    echo "Please re-download corrupted files"
    exit 1
fi

# List verified files
echo -e "\nVerified files:"
wc -l md5sums
ls -lh *.tar.* | wc -l
echo "files found in directory"

# Calculate total size
echo -e "\nTotal download size:"
du -sh *.tar.* | tail -n 1
