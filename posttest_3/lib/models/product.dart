import 'package:flutter/material.dart'; // Library Flutter

// Class untuk menyimpan data produk
class Product {
  final String id; // ID unik produk
  final String name; // Nama produk
  final int price; // Harga dalam bentuk angka
  final double rating; // Rating produk
  final IconData icon; // Icon pengganti gambar
  final String? imagePath; // Path gambar produk
  final String description; // Deskripsi produk
  int stock; // Stok produk yang dapat berubah

  // Constructor untuk membuat data produk
  Product({
    required this.id, // ID wajib diisi
    required this.name, // Nama wajib diisi
    required this.price, // Harga wajib diisi
    required this.rating, // Rating wajib diisi
    this.icon = Icons.local_florist, // Icon default
    this.imagePath, // Gambar bersifat opsional
    this.description = '', // Deskripsi default kosong
    this.stock = 20, // Stok awal 20
  });
}

// Mengubah angka menjadi format Rupiah
String formatRupiah(int value) {
  final digits = value.toString(); // Mengubah angka menjadi teks
  final buffer = StringBuffer(); // Menyimpan hasil format

  // Memisahkan angka setiap tiga digit
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.'); // Menambahkan titik pemisah
    }

    buffer.write(digits[i]); // Menambahkan angka
  }

  return 'Rp$buffer'; // Mengembalikan format Rupiah
}