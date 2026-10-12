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

env-run() {
    local env_file="${1:-.env}"
    if [[ -f "$env_file" ]]; then
        shift
        set -a
        source "$env_file"
        set +a
    else
        printf 'Env file not found: %s\n' "$env_file" >&2
        return 1
    fi

    "$@"
}

dotenv-run() {
    if [[ -f .env ]]; then
        set -a
        source .env
        set +a
    fi

    "$@"
}
