#!/bin/bash

# Infraestrutura como Código - Criação de usuários, grupos e estrutura de diretórios
# Autor: SeuNome
# Uso: sudo ./provision-structure.sh

echo "[*] Iniciando provisionamento da infraestrutura..."

# Grupos simulando setores
GROUPS=("devs" "security" "admins")

# Usuários por grupo
USERS_DEVS=("alice" "bob")
USERS_SECURITY=("mallory")
USERS_ADMINS=("rootops")

# Diretórios
BASE_DIR="/srv/empresa"

echo "[*] Criando grupos..."
for GROUP in "${GROUPS[@]}"; do
    groupadd "$GROUP" 2>/dev/null || echo "[!] Grupo $GROUP já existe"
done

echo "[*] Criando usuários..."
for USER in "${USERS_DEVS[@]}"; do
    useradd -m -s /bin/bash -G devs "$USER" 2>/dev/null && echo "[+] Criado usuário: $USER"
done

for USER in "${USERS_SECURITY[@]}"; do
    useradd -m -s /bin/bash -G security "$USER" 2>/dev/null && echo "[+] Criado usuário: $USER"
done

for USER in "${USERS_ADMINS[@]}"; do
    useradd -m -s /bin/bash -G admins "$USER" 2>/dev/null && echo "[+] Criado usuário: $USER"
done

echo "[*] Criando estrutura de diretórios em $BASE_DIR..."
mkdir -p "$BASE_DIR"/{devs,security,admins,public}

echo "[*] Definindo permissões..."
chown root:devs "$BASE_DIR/devs"
chown root:security "$BASE_DIR/security"
chown root:admins "$BASE_DIR/admins"
chmod 770 "$BASE_DIR/devs" "$BASE_DIR/security" "$BASE_DIR/admins"
chmod 777 "$BASE_DIR/public"

echo "[✓] Provisionamento concluído com sucesso."
