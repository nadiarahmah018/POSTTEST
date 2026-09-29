import 'package:flutter/material.dart';
import '../models/product.dart';
import '../pages/productDetailPage.dart';
import 'productImage.dart';

class ProductCardHorizontal extends StatelessWidget {
  // Properti Dart biasa (bukan widget baru) supaya data produk beda-beda
  final String name;
  final String price;
  final double rating;
  final IconData icon;
  final String? imagePath; // path gambar di assets (opsional)
  final String description;

  const ProductCardHorizontal({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    this.icon = Icons.local_florist,
    this.imagePath,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector membuat seluruh kartu bisa ditekan
    return GestureDetector(
      // Navigator.push: membuka halaman detail produk (ditumpuk di atas halaman sekarang)
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: Product(
                name: name,
                price: price,
                rating: rating,
                icon: icon,
                imagePath: imagePath,
                description: description,
              ),
            ),
          ),
        );
      },
      child: Container( // Container untuk membungkus seluruh isi card
        padding: const EdgeInsets.all(12), // jarak antara isi card dengan border card
        decoration: BoxDecoration( // BoxDecoration untuk mengatur tampilan card
          color: Colors.white,
          border: Border.all(color: const Color(0xFFAEC3B0)), // garis tepi
          borderRadius: BorderRadius.circular(12), // sudut container melengkung
          // BoxShadow memberi bayangan agar kartu terlihat timbul
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column( // Column untuk menyusun widget secara vertikal
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container( // Container untuk membungkus gambar produk
              width: double.infinity,
              height: 100,
              clipBehavior: Clip.antiAlias, // gambar ikut terpotong sesuai sudut melengkung
              decoration: BoxDecoration(
                color: const Color(0xFFE3EED4),
                borderRadius: BorderRadius.circular(8),
              ),
              // Stack menumpuk gambar produk dan ikon favorit di area yang sama
              child: Stack(
                children: [
                  // Lapisan paling bawah: gambar produk
                  Positioned.fill(
                    child: ProductImage(imagePath: imagePath, icon: icon, iconSize: 40),
                  ),
                  // Lapisan atas: ikon favorit di pojok kanan atas
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 14,
                        color: Color(0xFF375534),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // jarak vertikal
            Text( // nama produk
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2A1D),
              ),
            ),

            const SizedBox(height: 4),

            Row( // Row untuk menyusun widget secara horizontal
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '$rating',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF6B9071)),
                ),
              ],
            ),

            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF375534),
              ),
            ),

            const SizedBox(height: 8),
            SizedBox( // SizedBox untuk mengatur lebar tombol
              width: double.infinity,
              child: ElevatedButton(
                // menampilkan pesan singkat setelah tombol ditekan
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name ditambahkan ke keranjang')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF375534),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Icon(Icons.shopping_cart, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCardGrid extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final IconData icon;
  final String? imagePath;
  final String description;

  const ProductCardGrid({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    this.icon = Icons.local_florist,
    this.imagePath,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigator.push ke halaman detail produk
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: Product(
                name: name,
                price: price,
                rating: rating,
                icon: icon,
                imagePath: imagePath,
                description: description,
              ),
            ),
          ),
        );
      },
      child: Container( // Container untuk membungkus seluruh isi card
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFAEC3B0)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded( // mengisi sisa ruang yang tersedia di Column
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EED4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ProductImage(imagePath: imagePath, icon: icon, iconSize: 36),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: Color(0xFF375534),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2A1D),
              ),
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(Icons.star, size: 13, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '$rating',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF6B9071)),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              price,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF375534),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name ditambahkan ke keranjang')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF375534),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Icon(Icons.shopping_cart, size: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}