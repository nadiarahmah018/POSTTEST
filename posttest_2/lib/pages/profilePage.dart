import 'package:flutter/material.dart';
import '../widgets/productImage.dart';
import 'allProductPage.dart';
import 'cartPage.dart';

class ProfilePage extends StatelessWidget {
  // true jika halaman dibuka lewat Navigator.push (perlu tombol kembali)
  final bool showBackButton;

  const ProfilePage({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stack: header hijau + foto profil yang menumpuk di tepi bawah header
            Stack(
              clipBehavior: Clip.none, // agar avatar boleh keluar dari batas Stack
              children: [
                // Lapisan 1: latar header
                Container(
                  width: double.infinity,
                  height: 170,
                  decoration: const BoxDecoration(
                    color: Color(0xFF375534),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(28),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: const Text(
                    'Profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Lapisan 2: tombol kembali (hanya jika dibuka lewat Navigator.push)
                if (showBackButton)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 4,
                    left: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                // Lapisan 3: foto profil, setengah keluar dari header
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -45,
                  child: Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFAEC3B0),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      // Foto profil (Image.asset), jika belum ada tampil icon orang
                      child: ClipOval(
                        child: const ProductImage(
                          imagePath: 'assets/profile.jpg',
                          icon: Icons.person,
                          iconSize: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 56),

            const Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2A1D),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'pengguna@email.com',
              style: TextStyle(fontSize: 13, color: Color(0xFF6B9071)),
            ),

            const SizedBox(height: 24),

            // Statistik singkat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(child: _buildStat('12', 'Pesanan')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStat('5', 'Favorit')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStat('3', 'Ulasan')),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Daftar menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFAEC3B0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenu(
                      Icons.shopping_cart,
                      'Keranjang Saya',
                      // Navigator.push: buka halaman keranjang dengan tombol kembali
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(showBackButton: true),
                        ),
                      ),
                    ),
                    _buildMenu(
                      Icons.eco,
                      'Semua Produk',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllProductsPage(),
                        ),
                      ),
                    ),
                    _buildMenu(Icons.favorite_border, 'Favorit Saya'),
                    _buildMenu(Icons.settings, 'Pengaturan'),
                    _buildMenu(Icons.help_outline, 'Bantuan', showDivider: false),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Kotak statistik
  Widget _buildStat(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFAEC3B0)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF375534),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B9071)),
          ),
        ],
      ),
    );
  }

  // Satu baris menu
  Widget _buildMenu(
    IconData icon,
    String title, {
    VoidCallback? onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: const Color(0xFF375534)),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F2A1D),
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF6B9071)),
          onTap: onTap,
        ),
        if (showDivider) const Divider(height: 1, color: Color(0xFFE3EED4)),
      ],
    );
  }
}