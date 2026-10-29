# Linux System Health Checker

## 1. Deskripsi
Linux System Health Checker adalah shell script untuk
memeriksa keberadaan direktori dalam sebuah proyek Linux
dan mencatat hasil pemeriksaan ke file log.

## 2. Tujuan
Mengurangi pemeriksaan direktori secara manual serta
membantu administrator mengetahui hasil pemeriksaan
dan penyebab kegagalan melalui exit status dan log.

## 3. Kebutuhan
- Ubuntu Server
- Bash
- Terminal Linux
- Git untuk pengelolaan versi

## 4. Struktur Proyek
- src/: source script
- test/: catatan pengujian
- logs/: log aktivitas
- config/: konfigurasi contoh
- evidence/: screenshot hasil pengujian

## 5. Cara Menjalankan
Masuk ke direktori proyek:

    cd ~/linux-health-checker

Periksa sintaks:

    bash -n src/health-check.sh

Jalankan pemeriksaan:

    bash src/health-check.sh status "$HOME/linux-health-checker"

Periksa exit status:

    echo $?

Periksa log:

    cat logs/health-check.log

## 6. Pengujian
Lakukan satu pengujian berhasil dan minimal dua
pengujian gagal. Catat perintah, output aktual,
exit status, dan kesimpulan pada test/test-report.txt.

## 7. Keamanan
- Pengujian dilakukan pada direktori latihan.
- Script tidak menghapus atau mengubah data target.
- Tidak menyimpan password, token, atau private key.
- Log diperiksa agar tidak berisi data sensitif.

## 8. Pembersihan dan Rollback
Hentikan pengujian dan periksa kembali file proyek.
Hapus hanya file sementara yang dibuat untuk pengujian.
Source script, laporan, dan log dipertahankan sebagai bukti.

## 9. Batasan
Script hanya memeriksa direktori yang ditentukan.
Pemeriksaan penggunaan CPU, RAM, dan disk belum tersedia.
