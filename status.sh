#!/bin/bash

# Cek status autentikasi GitHub CLI
STATUS=$(gh auth status 2>&1)

# Fungsi untuk menampilkan pesan dengan warna
print_message() {
    echo -e "\033[1;36m$1\033[0m"
}

print_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Cek apakah autentikasi berhasil
if echo "$STATUS" | grep -q "You are logged in to GitHub"; then
    print_message "✔ GitHub CLI aktif dan terautentikasi."
else
    print_error "✘ GitHub CLI tidak aktif atau tidak terautentikasi."
fi

# Cek status sesi screen
SCREEN_STATUS=$(screen -list)

if echo "$SCREEN_STATUS" | grep -q "No Sockets found"; then
    print_error "✘ Tidak ada sesi Screen yang aktif."
else
    print_message "✔ Sesi Screen aktif:\n$SCREEN_STATUS"
fi
