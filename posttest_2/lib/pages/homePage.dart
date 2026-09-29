import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/productCard.dart';
import 'allProductPage.dart';
import 'cartPage.dart';
import 'profilePage.dart';

// halaman utama (Beranda) aplikasi Myplants
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold merupakan struktur dasar halaman (NavigationBar sekarang ada di MainPage)
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4),

      // AppBar digunakan sebagai bagian header aplikasi
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3EED4),
        elevation: 0,

        // Row menyusun logo dan nama aplikasi secara horizontal
        title: Row(
          children: [
            // Container digunakan sebagai kotak logo aplikasi
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF375534),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.eco, color: Colors.white, size: 20),
            ),

            const SizedBox(width: 10),

            const Text(
              'Myplants',
              style: TextStyle(
                color: Color(0xFF0F2A1D),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),

        // actions berisi widget yang berada di sebelah kanan AppBar
        actions: [
          // GestureDetector membuat tombol keranjang bisa ditekan
          GestureDetector(
            // Navigator.push: pindah ke halaman keranjang (dengan tombol kembali)
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(showBackButton: true),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFAEC3B0)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    size: 18,
                    color: Color(0xFF375534),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF375534),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Ikon profil, bisa ditekan untuk membuka halaman profil
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push( // pindah ke halaman profil (dengan tombol kembali)
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(showBackButton: true),
                  ),
                );
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFAEC3B0),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF0F2A1D),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),

      // SafeArea memastikan isi halaman tidak tertutup area sistem
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari tanaman hias...',
                    hintStyle: const TextStyle(color: Color(0xFF6B9071)),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.search, size: 24, color: Color(0xFF6B9071)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Color(0xFFAEC3B0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Color(0xFFAEC3B0)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                ),
              ),

              // Banner promosi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(child: _buildBanner('Diskon 20%', 'Tanaman indoor', Icons.eco)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildBanner('Gratis Ongkir', 'Min. Rp100.000', Icons.local_shipping)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildBanner('Koleksi Baru', 'Gantung minimalis', Icons.spa)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2A1D),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Kategori bisa digeser horizontal
              SizedBox(
                height: 40,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      _buildCategoryChip('Semua', isSelected: true),
                      const SizedBox(width: 10),
                      _buildCategoryChip('Indoor'),
                      const SizedBox(width: 10),
                      _buildCategoryChip('Outdoor'),
                      const SizedBox(width: 10),
                      _buildCategoryChip('Kaktus'),
                      const SizedBox(width: 10),
                      _buildCategoryChip('Gantung'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Judul produk terlaris + tombol Lihat Semua
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Produk Terlaris',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F2A1D),
                      ),
                    ),

                    ElevatedButton(
                      // Navigator.push: buka halaman semua produk
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllProductsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: const Color(0xFF375534),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Lihat Semua',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // 3 produk terlaris secara horizontal (diambil dari dummyProducts)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 3; i++) ...[
                      if (i > 0) const SizedBox(width: 14),
                      Expanded(
                        child: ProductCardHorizontal(
                          name: dummyProducts[i].name,
                          price: dummyProducts[i].price,
                          rating: dummyProducts[i].rating,
                          icon: dummyProducts[i].icon,
                          imagePath: dummyProducts[i].imagePath,
                          description: dummyProducts[i].description,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Semua Produk',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2A1D),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // GridView 2 kolom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.68,
                  shrinkWrap: true,
                  // scroll grid dimatikan karena sudah ada SingleChildScrollView
                  physics: const NeverScrollableScrollPhysics(),
                  children: dummyProducts
                      .map(
                        (p) => ProductCardGrid(
                          name: p.name,
                          price: p.price,
                          rating: p.rating,
                          icon: p.icon,
                          imagePath: p.imagePath,
                          description: p.description,
                        ),
                      )
                      .toList(),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Membuat banner; Stack + Positioned dipakai untuk menaruh ikon dekoratif di pojok
  Widget _buildBanner(String title, String subtitle, IconData icon) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF375534),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Ikon dekoratif di pojok kanan bawah (lapisan bawah)
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(icon, size: 56, color: Colors.white.withOpacity(0.15)),
          ),

          // Teks banner (lapisan atas)
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(color: Color(0xFFE3EED4), fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Membuat tombol kategori
  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF375534) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? const Color(0xFF375534) : const Color(0xFFAEC3B0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF0F2A1D),
        ),
      ),
    );
  }
}