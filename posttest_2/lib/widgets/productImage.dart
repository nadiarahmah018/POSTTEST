import 'package:flutter/material.dart';
// Widget untuk menampilkan gambar produk.
// Jika imagePath kosong atau file gambar belum ada, otomatis tampil icon pengganti,
// sehingga aplikasi tetap jalan walaupun gambar belum diupload.
class ProductImage extends StatelessWidget {
  final String? imagePath;
  final IconData icon;
  final double iconSize;

  const ProductImage({
    super.key,
    this.imagePath,
    this.icon = Icons.local_florist,
    this.iconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    // Icon pengganti ketika gambar tidak tersedia
    final fallback = Container(
      color: const Color(0xFFE3EED4),
      child: Center(
        child: Icon(icon, size: iconSize, color: const Color(0xFF6B9071)),
      ),
    );

    if (imagePath == null) return fallback;

    // Image.asset menampilkan gambar dari folder assets
    return Image.asset(
      imagePath!,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover, // gambar memenuhi area dan dipotong jika perlu
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}