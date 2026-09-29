import 'package:flutter/material.dart';

// Model untuk menyimpan data satu produk
class Product {
  final String name;
  final String price;
  final double rating;
  final IconData icon;

  // path gambar di folder assets (boleh null, jika null/tidak ditemukan tampil icon)
  final String? imagePath;
  final String description;

  const Product({
    required this.name,
    required this.price,
    required this.rating,
    this.icon = Icons.local_florist,
    this.imagePath,
    this.description = '',
  });
}
// Data produk contoh yang dipakai di Beranda, Semua Produk, dll.
const List<Product> dummyProducts = [
  Product(
    name: 'Monstera Deliciosa',
    price: 'Rp85.000',
    rating: 4.8,
    icon: Icons.eco,
    imagePath: 'assets/monstera.jpg',
    description:
        'Tanaman hias indoor dengan daun besar berlubang yang khas. Mudah dirawat dan cocok diletakkan di ruang tamu.',
  ),
  Product(
    name: 'Lidah Mertua',
    price: 'Rp45.000',
    rating: 4.6,
    icon: Icons.grass,
    imagePath: 'assets/lidah_mertua.jpg',
    description:
        'Tanaman tahan banting yang bisa hidup di cahaya rendah dan membantu menyaring udara dalam ruangan.',
  ),
  Product(
    name: 'Kaktus Mini',
    price: 'Rp25.000',
    rating: 4.5,
    icon: Icons.park,
    imagePath: 'assets/kaktus.jpg',
    description:
        'Kaktus berukuran kecil, cocok untuk dekorasi meja kerja. Cukup disiram seminggu sekali.',
  ),
  Product(
    name: 'Sirih Gading',
    price: 'Rp35.000',
    rating: 4.7,
    icon: Icons.local_florist,
    imagePath: 'assets/sirih_gading.jpg',
    description:
        'Tanaman merambat dengan daun berwarna hijau-kuning yang indah, cocok untuk pot gantung.',
  ),
  Product(
    name: 'Palem Kuning',
    price: 'Rp120.000',
    rating: 4.4,
    icon: Icons.forest,
    imagePath: 'assets/palem_kuning.jpg',
    description:
        'Palem cantik dengan tampilan tropis yang memberi kesan segar pada teras maupun ruangan.',
  ),
  Product(
    name: 'Aglonema',
    price: 'Rp65.000',
    rating: 4.9,
    icon: Icons.spa,
    imagePath: 'assets/aglonema.jpg',
    description:
        'Tanaman dengan corak daun merah muda yang menarik dan tahan di ruangan minim cahaya.',
  ),
];