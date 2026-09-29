import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/productCard.dart';

// Halaman semua produk, dibuka dari tombol "Lihat Semua" lewat Navigator.push
class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3EED4),
        elevation: 0,
        // tombol kembali memakai Navigator.pop
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2A1D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Semua Produk',
          style: TextStyle(
            color: Color(0xFF0F2A1D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: dummyProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          final p = dummyProducts[index];
          return ProductCardGrid(
            name: p.name,
            price: p.price,
            rating: p.rating,
            icon: p.icon,
            imagePath: p.imagePath,
            description: p.description,
          );
        },
      ),
    );
  }
}