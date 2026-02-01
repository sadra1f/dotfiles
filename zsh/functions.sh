set-proxy() {
    export ALL_PROXY=$1
    export all_proxy=$1
    export HTTP_PROXY=$1
    export http_proxy=$1
    export HTTPS_PROXY=$1
    export https_proxy=$1
}

unset-proxy() {
    unset ALL_PROXY
    unset all_proxy
    unset HTTP_PROXY
    unset http_proxy
    unset HTTPS_PROXY
    unset https_proxy
}

ssh-start-and-add() {
    eval "$(ssh-agent -s)"
    ssh-add $1
}

generate-secure-key() {
    SECURE_KEY_LENGTH=${1:-16}
    SECURE_KEY_CHARS='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    (
        echo "import secrets"
        echo "print(''.join(secrets.choice('$SECURE_KEY_CHARS') for _ in range($SECURE_KEY_LENGTH)))"
    ) | python3
}
