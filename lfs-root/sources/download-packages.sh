#!/bin/bash

# LFS packages download script
set -e

LFS_MIRROR="https://www.linuxfromscratch.org/lfs/downloads/12.3"
GNU_MIRROR="https://ftp.gnu.org/gnu"
KERNEL_MIRROR="https://www.kernel.org/pub/linux/kernel"

# Create directories
mkdir -p packages patches

echo "Starting package downloads..."

# Download function
download_file() {
    local url=$1
    local filename=$2
    
    if [ ! -f "$filename" ]; then
        echo "Downloading $filename..."
        wget -c "$url/$filename" || {
            echo "Failed to download $filename from $url"
            return 1
        }
    else
        echo "$filename already exists, skipping..."
    fi
}

# Download packages from various sources
echo "Downloading GNU packages..."

# GNU packages
download_file "$GNU_MIRROR/autoconf" "autoconf-2.72.tar.xz"
download_file "$GNU_MIRROR/automake" "automake-1.17.tar.xz"
download_file "$GNU_MIRROR/bash" "bash-5.2.tar.gz"
download_file "https://github.com/gavinhoward/bc/releases/download/7.0.3" "bc-7.0.3.tar.xz"
download_file "$GNU_MIRROR/binutils" "binutils-2.43.1.tar.xz"
download_file "$GNU_MIRROR/bison" "bison-3.8.2.tar.xz"
download_file "$GNU_MIRROR/coreutils" "coreutils-9.7.tar.xz"
download_file "$GNU_MIRROR/diffutils" "diffutils-3.10.tar.xz"
download_file "$GNU_MIRROR/findutils" "findutils-4.10.0.tar.xz"
download_file "$GNU_MIRROR/gawk" "gawk-5.3.1.tar.xz"
download_file "$GNU_MIRROR/gcc" "gcc-14.2.0.tar.xz"
download_file "$GNU_MIRROR/gettext" "gettext-0.23.tar.xz"
download_file "$GNU_MIRROR/glibc" "glibc-2.40.tar.xz"
download_file "$GNU_MIRROR/gmp" "gmp-6.3.0.tar.xz"
download_file "$GNU_MIRROR/grep" "grep-3.11.tar.xz"
download_file "$GNU_MIRROR/groff" "groff-1.23.0.tar.gz"
download_file "$GNU_MIRROR/grub" "grub-2.12.tar.xz"
download_file "$GNU_MIRROR/gzip" "gzip-1.13.tar.xz"
download_file "$GNU_MIRROR/libtool" "libtool-2.5.4.tar.xz"
download_file "$GNU_MIRROR/m4" "m4-1.4.19.tar.xz"
download_file "$GNU_MIRROR/make" "make-4.4.1.tar.gz"
download_file "$GNU_MIRROR/mpc" "mpc-1.3.1.tar.gz"
download_file "$GNU_MIRROR/mpfr" "mpfr-4.2.1.tar.xz"
download_file "$GNU_MIRROR/patch" "patch-2.7.6.tar.xz"
download_file "$GNU_MIRROR/sed" "sed-4.9.tar.xz"
download_file "$GNU_MIRROR/tar" "tar-1.35.tar.xz"
download_file "$GNU_MIRROR/texinfo" "texinfo-7.1.1.tar.xz"

echo "GNU packages download completed"

# Download kernel
echo "Downloading Linux kernel..."
download_file "$KERNEL_MIRROR/v6.x" "linux-6.12.6.tar.xz"

echo "Package download completed!"
echo "Please verify checksums before proceeding."
