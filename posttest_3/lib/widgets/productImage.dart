import 'package:flutter/material.dart'; // Library Flutter

// Widget untuk menampilkan gambar produk
class ProductImage extends StatelessWidget {
  final String? imagePath; // Path gambar produk
  final IconData icon; // Icon pengganti gambar
  final double iconSize; // Ukuran icon

  // Constructor ProductImage
  const ProductImage({
    super.key, // Key widget
    this.imagePath, // Path gambar bersifat opsional
    this.icon = Icons.local_florist, // Icon default
    this.iconSize = 40, // Ukuran icon default
  });

  @override
  Widget build(BuildContext context) {
    // Container pengganti jika gambar tidak tersedia
    final fallback = Container(
      color: const Color(0xFFE3EED4), // Warna background
      child: Center(
        child: Icon(
          icon, // Menampilkan icon
          size: iconSize, // Ukuran icon
          color: const Color(0xFF6B9071), // Warna icon
        ),
      ),
    );

    // Jika path gambar kosong, tampilkan icon pengganti
    if (imagePath == null) return fallback;

    // Menampilkan gambar dari folder assets
    return Image.asset(
      imagePath!, // Path gambar
      width: double.infinity, // Lebar mengikuti area
      height: double.infinity, // Tinggi mengikuti area
      fit: BoxFit.cover, // Gambar memenuhi area
      errorBuilder: (context, error, stackTrace) =>
          fallback, // Jika gambar gagal dimuat
    );
  }
}