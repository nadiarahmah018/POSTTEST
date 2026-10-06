import 'package:flutter/material.dart'; // Library Flutter
import 'package:provider/provider.dart'; // Modul 5 - Provider
import '../providers/cartProvider.dart'; // Provider keranjang
import '../widgets/productCard.dart'; // Widget kartu produk

// Halaman untuk menampilkan semua produk
class AllProductsPage extends StatelessWidget {
  const AllProductsPage({
    super.key, // Key widget
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4), // Warna background

      // AppBar halaman
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3EED4),
        elevation: 0,

        // Tombol kembali ke halaman sebelumnya
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0F2A1D),
          ),
          onPressed: () => Navigator.pop(context),
        ),

        // Judul halaman
        title: const Text(
          'Semua Produk',
          style: TextStyle(
            color: Color(0xFF0F2A1D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      // Mengambil data produk dari CartProvider
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          // Mengambil produk yang stoknya masih tersedia
          final products = cart.products
              .where((p) => p.stock > 0)
              .toList();

          // Menampilkan produk dalam bentuk grid
          return GridView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: products.length,

            // Mengatur bentuk dan jarak grid
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Jumlah kolom
              crossAxisSpacing: 14, // Jarak antar kolom
              mainAxisSpacing: 14, // Jarak antar baris
              childAspectRatio: 0.68, // Perbandingan ukuran kartu
            ),

            // Membuat kartu untuk setiap produk
            itemBuilder: (context, index) {
              return ProductCardGrid(
                product: products[index], // Data produk
              );
            },
          );
        },
      ),
    );
  }
}