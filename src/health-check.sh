#!/bin/bash

# Linux System Health Checker
# Otomasi pemeriksaan direktori Linux

set -u

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/health-check.log"

# Fungsi untuk mencatat aktivitas
write_log() {
    local message="$1"
    local timestamp

    timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

    if ! printf '[%s] %s\n' "$timestamp" "$message" >> "$LOG_FILE"; then
        printf 'ERROR: Gagal menulis log.\n' >&2
        return 1
    fi
}

# Fungsi untuk menampilkan bantuan
show_usage() {
    echo "Penggunaan:"
    echo "  $0 status TARGET_DIRECTORY"
    echo
    echo "Contoh:"
    echo "  $0 status $HOME/linux-health-checker"
}

# Fungsi validasi input
validate_input() {
    if [[ "$#" -ne 2 ]]; then
        echo "ERROR: Jumlah argumen harus 2." >&2
        return 1
    fi

    if [[ "$1" != "status" ]]; then
        echo "ERROR: Aksi tidak dikenal: $1" >&2
        return 1
    fi

    if [[ -z "$2" ]]; then
        echo "ERROR: Direktori target tidak boleh kosong." >&2
        return 1
    fi

    return 0
}

# Fungsi pemeriksaan direktori
check_directory() {
    local target="$1"

    if [[ ! -d "$target" ]]; then
        echo "ERROR: Direktori tidak ditemukan: $target" >&2
        write_log "FAIL: Direktori tidak ditemukan: $target" || return 3
        return 2
    fi

    if [[ ! -r "$target" || ! -x "$target" ]]; then
        echo "ERROR: Direktori tidak dapat diakses." >&2
        write_log "FAIL: Akses direktori ditolak: $target" || return 3
        return 3
    fi

    return 0
}

# Fungsi audit resource
audit_resources() {
    local target="$1"
    local item
    local path

    local resources=("src" "test" "logs" "config" "evidence")

    echo "=== LINUX SYSTEM HEALTH CHECKER ==="
    echo "Waktu pemeriksaan: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Direktori target: $target"
    echo

    for item in "${resources[@]}"; do
        path="$target/$item"

        if [[ -d "$path" ]]; then
            printf '[OK]      Direktori %s tersedia\n' "$item"
            write_log "OK: Direktori tersedia: $path" || return 3
        else
            printf '[INFO]    Direktori %s belum tersedia\n' "$item"
            write_log "INFO: Direktori belum tersedia: $path" || return 3
        fi
    done

    echo
    echo "Pemeriksaan selesai."
    write_log "SUCCESS: Pemeriksaan selesai untuk $target" || return 3
    return 0
}


# Program utama
main() {
    local result
    local target

    if ! mkdir -p "$LOG_DIR"; then
        echo "ERROR: Tidak dapat membuat folder log." >&2
        return 3
    fi

    if validate_input "$@"; then
        :
    else
        show_usage
        write_log "FAIL: Input tidak valid" || return 3
        return 1
    fi

    target="$2"

    if check_directory "$target"; then
        :
    else
        result=$?
        return "$result"
    fi

    audit_resources "$target"
}

main "$@"
exit $?
