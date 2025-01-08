#!/bin/bash

# Fungsi untuk menampilkan pesan dengan warna
print_message() {
    echo -e "\033[1;36m$1\033[0m"
}

print_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Cek status autentikasi GitHub CLI
STATUS=$(gh auth status 2>&1)

# Cek apakah autentikasi berhasil
GITHUB_STATUS=""
if echo "$STATUS" | grep -q "Logged in to github.com"; then
    GITHUB_STATUS="Aktif"
else
    GITHUB_STATUS="Tidak Aktif"
fi

SCREEN_STATUS=$(screen -list | grep -oP '\d+\.\S+')

if [ -z "$SCREEN_STATUS" ]; then
    SCREEN_STATUS="Tidak Aktif"
else
    SCREEN_STATUS="Sesi aktif:\n$SCREEN_STATUS"
fi

# Menampilkan informasi dengan format yang diinginkan
echo "============================="
echo "             DOT GITHUB CLI"
echo "============================="
echo "Github Status    : $GITHUB_STATUS"
echo "Screen           : $SCREEN_STATUS"
echo "Waktu            : $(date)"
echo "============================="
