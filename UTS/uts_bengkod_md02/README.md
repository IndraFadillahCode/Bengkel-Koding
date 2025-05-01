# Todo List Film App

Aplikasi **Todo List Film** adalah aplikasi berbasis Flutter yang memungkinkan pengguna untuk menambahkan, mengedit, menghapus, dan menandai film sebagai selesai. Aplikasi ini juga mendukung pencarian film berdasarkan judul dan menampilkan gambar poster film.

## Fitur Utama
- **Tambah Film**: Pengguna dapat menambahkan film baru dengan judul, deskripsi, dan gambar poster.
- **Edit Film**: Pengguna dapat mengedit data film yang sudah ada.
- **Hapus Film**: Pengguna dapat menghapus film tertentu atau semua film yang telah selesai.
- **Checklist**: Menandai film sebagai selesai atau belum selesai.
- **Pencarian**: Mencari film berdasarkan judul.
- **Tampilan Gambar**: Menampilkan poster film.
- **Splash Screen**: Menampilkan layar pembuka saat aplikasi pertama kali dijalankan.

## Alur Pengerjaan
1. **Persiapan Proyek**:
   - Membuat proyek Flutter baru.
   - Menambahkan dependensi seperti `image_picker` untuk memilih gambar dari galeri.

2. **Membuat Database**:
   - Membuat kelas `DatabaseHelper` untuk mengelola database SQLite.
   - Menambahkan fungsi untuk menyimpan, memperbarui, menghapus, dan mengambil data film.

3. **Membuat Model**:
   - Membuat kelas `Todo` sebagai model data untuk film.

4. **Membuat Halaman Utama**:
   - Membuat halaman utama (`TodoPage`) dengan daftar film menggunakan `ListView.builder`.
   - Menambahkan fitur pencarian untuk memfilter daftar film.

5. **Menambahkan Fitur Tambah/Edit**:
   - Membuat dialog form untuk menambahkan atau mengedit film.
   - Menambahkan validasi input dan fitur untuk memilih gambar dari galeri.

6. **Menambahkan Fitur Checklist**:
   - Menambahkan lingkaran checklist di sebelah kiri setiap item.
   - Memastikan status checklist diperbarui di database.

7. **Menambahkan Fitur Hapus**:
   - Menambahkan tombol untuk menghapus film tertentu.
   - Menambahkan tombol untuk menghapus semua film yang telah selesai.

8. **Menambahkan Notifikasi**:
   - Menambahkan `SnackBar` untuk menampilkan pesan saat film berhasil ditambahkan, diperbarui, atau dihapus.

9. **Menambahkan Splash Screen**:
   - Membuat halaman splash screen menggunakan `Timer` untuk menampilkan layar pembuka selama beberapa detik.
   - Mengarahkan pengguna ke halaman utama setelah splash screen selesai.

## Struktur Folder
```
lib/
├── main.dart          # Entry point aplikasi
├── todo_page.dart     # Halaman utama aplikasi
├── splash_screen.dart # Halaman splash screen
├── database_helper.dart # Kelas untuk mengelola database SQLite
├── todo.dart          # Model data untuk film
```

## Cara Menjalankan Aplikasi
1. Pastikan Anda telah menginstal Flutter di komputer Anda.
2. Clone repository ini:
   ```bash
   git clone <repository-url>
   ```
3. Masuk ke direktori proyek:
   ```bash
   cd <project-directory>
   ```
4. Jalankan perintah berikut untuk menginstal dependensi:
   ```bash
   flutter pub get
   ```
5. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Teknologi yang Digunakan
- **Flutter**: Framework utama untuk pengembangan aplikasi.
- **SQLite**: Database lokal untuk menyimpan data film.
- **Image Picker**: Untuk memilih gambar dari galeri.

## Pengembang
- **Nama**: Indra Fadillah
- **Nim**: A11.2022.14186
