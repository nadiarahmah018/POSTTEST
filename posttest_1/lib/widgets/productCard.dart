import 'package:flutter/material.dart';

class ProductCardHorizontal extends StatelessWidget {
  // Properti Dart biasa (bukan widget baru) supaya data produk beda-beda
  final String name;
  final String price;
  final double rating;
  final IconData icon;

  const ProductCardHorizontal({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    this.icon = Icons.local_florist,
  });

  @override
  Widget build(BuildContext context) {

    return Container( // Container untuk membungkus seluruh isi card
      padding: const EdgeInsets.all(12), //padding memberikan jarak antara isi card dengan border card
      decoration: BoxDecoration( // BoxDecoration untuk mengatur tampilan card
        color: Colors.white, 
        border: Border.all(color: const Color(0xFFAEC3B0)), // garis tepi
        borderRadius: BorderRadius.circular(12), // sudut container melengkung
      ),
      child: Column( // Column untuk menyusun widget secara vertikal
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( // Container untuk membungkus icon produk
            width: double.infinity, // lebar mengikuti parent
            height: 100, // tinggi container
            decoration: BoxDecoration(
              color: const Color(0xFFE3EED4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 40, color: const Color(0xFF6B9071)), // menampilkan icon produk
          ),
          const SizedBox(height: 8), // SizedBox jarak vertikal 
          Text( // menampilkan nama produk
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle( // TextStyle untuk mengatur tampilan teks
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F2A1D),
            ),
          ),

          const SizedBox(height: 4), // SizedBox untuk memberikan jarak vertikal

          Row( // Row untuk menyusun widget secara horizontal
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber), // menampilkan icon bintang
              const SizedBox(width: 4),
              Text(
                '$rating',
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B9071)),
              ),
            ],
          ),

          const SizedBox(height: 4), // SizedBox untuk memberikan jarak vertikal
          Text(
            price,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF375534),
            ),
          ),

          const SizedBox(height: 8), // SizedBox untuk memberikan jarak vertikal
          SizedBox( // SizedBox untuk mengatur lebar tombol
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF375534),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Icon(Icons.shopping_cart, size: 16), // menampilkan icon keranjang belanja
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCardGrid extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final IconData icon;

  const ProductCardGrid({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    this.icon = Icons.local_florist,
  });

  @override
  Widget build(BuildContext context) {

    return Container( // Container untuk membungkus seluruh isi card
      padding: const EdgeInsets.all(12), // padding memberikan jarak antara isi card dengan border card
      decoration: BoxDecoration( // BoxDecoration untuk mengatur tampilan card
        color: Colors.white,
        border: Border.all(color: const Color(0xFFAEC3B0)), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column( // Column untuk menyusun widget secara vertikal
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded( // Expanded untuk mengisi ruang yang tersedia di sisa ruang Column
            child: Container( // Container untuk membuat area icon produk
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE3EED4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 36, color: const Color(0xFF6B9071)),
            ),
          ),

          const SizedBox(height: 8), // SizedBox untuk memberikan jarak vertikal

          Text( // menampilkan nama produk
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F2A1D),
            ),
          ),

          const SizedBox(height: 4), // SizedBox untuk memberikan jarak vertikal

          Row( // Row untuk menyusun widget secara horizontal
            children: [
              const Icon(Icons.star, size: 13, color: Colors.amber),
              const SizedBox(width: 4), // SizedBox untuk memberikan jarak horizontal
              Text( // menampilkan rating produk
                '$rating',
                style: const TextStyle(fontSize: 11, color: Color(0xFF6B9071)),
              ),
            ],
          ),

          const SizedBox(height: 4), // SizedBox untuk memberikan jarak vertikal

          Text( // menampilkan harga produk
            price,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF375534),
            ),
          ),

          const SizedBox(height: 8), // SizedBox untuk memberikan jarak vertikal

          SizedBox( // SizedBox untuk mengatur lebar tombol
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF375534),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Icon(Icons.shopping_cart, size: 15), // menampilkan icon keranjang belanja
            ),
          ),
        ],
      ),
    );
  }
}