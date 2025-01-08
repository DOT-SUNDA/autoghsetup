#!/bin/bash

TOKEN=$0

# Pastikan token diberikan sebagai argumen
if [ -z "$TOKEN" ]; then
    echo "Token GitHub tidak diberikan"
    exit 1
fi

echo "Memulai setup GitHub CLI dan konfigurasi Codespace tanpa root..."

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

# Ambil repositori pertama dan konfigurasi Codespace
REPO=$(gh repo list --limit 1 --json nameWithOwner --jq '.[0].nameWithOwner')

gh codespace create --repo "$REPO" --branch "main" --machine "standardLinux32gb"

gh codespace create --repo "$REPO" --branch "main" --machine "standardLinux32gb"

