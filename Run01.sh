#!/bin/bash

# Periksa apakah GitHub CLI tersedia
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) tidak ditemukan. Silakan instal terlebih dahulu."
    exit 1
fi

echo "Memulai GitHub Codespace pertama..."

# Mendapatkan daftar Codespace yang tersedia (status Available atau Shutdown)
codespaces=($(gh codespace list | grep -E 'Available|Shutdown' | awk '{print $1}'))

# Periksa apakah ada Codespace yang tersedia
if [ -z "${codespaces[0]}" ]; then
    echo "Tidak ada Codespace pertama yang tersedia. Pastikan Anda memiliki Codespace yang aktif atau shutdown."
    exit 1
fi

# Jalankan Codespace pertama
echo "Mengakses Codespace pertama: ${codespaces[0]}"
gh codespace ssh --codespace "${codespaces[0]}" -- -tt
