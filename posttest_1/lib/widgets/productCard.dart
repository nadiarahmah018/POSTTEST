import 'package:flutter/material.dart';

// ProductCard -> widget custom untuk menampilkan 1 produk tanaman.
// Dibangun dari Container, Row, Column, Text, Icon, SizedBox, dan
// ElevatedButton, semua widget dasar yang dipelajari di modul 2.
class ProductCard extends StatelessWidget {
  // name, description, price -> properti Dart biasa (bukan widget baru),
  // dipakai supaya setiap ProductCard bisa diisi data produk yang berbeda-beda
  final String name;
  final String description;
  final String price;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Container -> membungkus seluruh card. Dipakai untuk mengatur padding,
    // warna, border, dan borderRadius (lihat Modul 2 - Container)
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFAEC3B0), // border hijau muda dari palet toko
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      // Row -> menyusun gambar produk dan informasi produk secara horizontal
      // (Modul 2 - Column dan Row)
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ================= Gambar Produk (placeholder) =================
          // Container -> dipakai sebagai kotak gambar produk, karena belum
          // ada foto asli
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFE3EED4), // warna cream sebagai latar placeholder
              borderRadius: BorderRadius.circular(8),
            ),
            // Icon -> sementara dipakai sebagai pengganti foto tanaman asli
            // (Modul 2 - Icon)
            child: const Icon(
              Icons.local_florist,
              size: 48,
              color: Color(0xFF6B9071),
            ),
          ),

          const SizedBox(width: 16), // SizedBox -> memberi jarak horizontal

          // ================= Informasi Produk =================
          // Expanded -> memaksa Column mengisi sisa ruang yang tersedia
          // pada Row (Modul 2 - Expanded)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text -> menampilkan nama produk (Modul 2 - Text)
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2A1D), // hijau tua dari palet toko
                  ),
                ),

                const SizedBox(height: 4),

                // Text -> menampilkan deskripsi singkat produk
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B9071),
                  ),
                ),

                const SizedBox(height: 4),

                // Text -> menampilkan harga produk
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF375534),
                  ),
                ),

                const SizedBox(height: 8),

                // ElevatedButton -> tombol untuk menambahkan produk ke keranjang
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF375534),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(
                      double.infinity,
                      42,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  // Row -> menyusun icon dan text tombol secara horizontal
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Masukkan Keranjang',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}