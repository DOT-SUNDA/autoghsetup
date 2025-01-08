#!/bin/bash

# Periksa apakah sudah login ke GitHub CLI
gh auth status > /dev/null
if [ $? -ne 0 ]; then
    echo "You need to log in to GitHub CLI first."
    exit 1
fi

# Ambil repositori pertama dari akun GitHub
REPO=$(gh repo list --limit 1 --json nameWithOwner --jq '.[0].nameWithOwner')

if [ -z "$REPO" ]; then
    echo "Tidak ada repositori ditemukan di akun GitHub Anda."
    exit 1
fi

# Tentukan branch default (ubah jika perlu)
BRANCH="main"

# Tentukan spesifikasi Codespace (4 vCPU, 8GB RAM)
MACHINE_TYPE="standardLinux"

# Membuat Codespace secara otomatis
echo "Membuat Codespace untuk repositori $REPO pada branch $BRANCH dengan mesin $MACHINE_TYPE..."
gh codespace create --repo "$REPO" --branch "$BRANCH" --machine "$MACHINE_TYPE"

if [ $? -eq 0 ]; then
    echo "Codespace berhasil dibuat untuk repositori $REPO pada branch $BRANCH dengan mesin $MACHINE_TYPE."
else
    echo "Gagal membuat Codespace."
    exit 1
fi
