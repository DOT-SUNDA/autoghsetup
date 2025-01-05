#!/bin/bash

TOKEN=$0

# Pastikan token diberikan sebagai argumen
if [ -z "$TOKEN" ]; then
    echo "Token GitHub tidak diberikan"
    echo "Gunakan: ./script.sh <GitHub_Token>"
    exit 1
fi

echo "Memulai setup GitHub CLI dan konfigurasi Codespace tanpa root..."

# Cek apakah `gh` sudah terinstal
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) tidak ditemukan. Silakan instal secara manual."
    echo "Ikuti petunjuk di https://github.com/cli/cli#installation untuk instalasi."
    exit 1
fi

# Verifikasi instalasi GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI belum tersedia. Silakan instal terlebih dahulu."
    exit 1
fi

echo "GitHub CLI ditemukan!"

# Konfigurasi autentikasi menggunakan token
echo "Mengatur autentikasi GitHub CLI..."
echo "${TOKEN}" | gh auth login --with-token

# Tes autentikasi
if gh auth status &> /dev/null; then
    echo "Autentikasi berhasil!"
else
    echo "Autentikasi gagal. Periksa token Anda."
    exit 1
fi