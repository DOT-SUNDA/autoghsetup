#!/bin/bash

# Periksa apakah GitHub CLI tersedia
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) tidak ditemukan. Silakan instal terlebih dahulu."
    exit 1
fi

echo "Memulai GitHub Codespace kedua..."

# Mendapatkan daftar Codespace yang tersedia (status Available atau Shutdown)
codespaces=($(gh codespace list | grep -E 'Available|Shutdown' | awk '{print $1}'))

# Periksa apakah ada Codespace kedua yang tersedia
if [ -z "${codespaces[1]}" ]; then
    echo "Tidak ada Codespace kedua yang tersedia. Pastikan Anda memiliki Codespace yang aktif atau shutdown."
    exit 1
fi

# Jalankan Codespace kedua
echo "Mengakses Codespace kedua: ${codespaces[1]}"
gh codespace ssh --codespace "${codespaces[1]}" -- -tt
