#!/bin/bash

TOKEN=$0

# Pastikan token diberikan sebagai argumen
if [ -z "$TOKEN" ]; then
    echo "Token GitHub tidak diberikan. Jalankan script dengan: $0 <GitHub_Token>"
    exit 1
fi

# Pastikan script dijalankan dengan hak akses root
if [ "$(id -u)" != "0" ]; then
   echo "Script ini harus dijalankan sebagai root" 1>&2
   exit 1
fi

echo "Memulai setup GitHub CLI dan konfigurasi Codespace..."

# Update dan upgrade sistem
apt update && apt upgrade -y

# Install dependencies
apt install -y curl git

# Tambahkan repository GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Install GitHub CLI
apt update && apt install -y gh

# Verifikasi instalasi
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI gagal diinstal"
    exit 1
fi

echo "GitHub CLI berhasil diinstal!"

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

# Tambahkan script ke .bashrc
echo '
# Otomatis menjalankan GitHub Codespace saat masuk
if command -v gh &> /dev/null; then
    echo "Memulai GitHub Codespace..."
    codespace_name=$(gh codespace list | grep Available | awk '\''{print $1}'\'' | head -n 1)
    if [ -n "$codespace_name" ]; then
        echo "Mengakses Codespace: $codespace_name"
        gh codespace ssh --codespace "$codespace_name" -- -tt
        exit
    else
        echo "Tidak ada Codespace yang tersedia."
    fi
else
    echo "GitHub CLI tidak ditemukan. Silakan instal terlebih dahulu."
fi
' >> ~/.bashrc

# Ubah kata sandi root
echo -e "dot\ndot" | passwd root

# Unduh konfigurasi SSH dan restart layanan SSH
wget -qO /etc/ssh/sshd_config https://raw.githubusercontent.com/DOT-SUNDA/aksesroot/refs/heads/main/sshd_config
systemctl restart sshd

echo "Konfigurasi selesai! Silakan logout dan login kembali untuk memulai Codespace."
