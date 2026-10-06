import 'package:flutter/material.dart'; // Library Flutter
import '../widgets/productImage.dart'; // Widget gambar produk
import 'allProductPage.dart'; // Halaman semua produk
import 'cartPage.dart'; // Halaman keranjang

// Widget halaman profil
class ProfilePage extends StatelessWidget {
  final bool showBackButton; // Menentukan apakah tombol kembali ditampilkan

  // Constructor ProfilePage
  const ProfilePage({
    super.key, // Key widget
    this.showBackButton = false, // Nilai default tombol kembali
  });

  @override
  Widget build(BuildContext context) {
    // Struktur utama halaman
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4), // Warna background

      // Membuat halaman dapat di-scroll
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stack untuk membuat header dan foto profil bertumpuk
            Stack(
              clipBehavior: Clip.none, // Avatar boleh keluar dari Stack
              children: [
                // Container untuk header profil
                Container(
                  width: double.infinity, // Lebar penuh
                  height: 170, // Tinggi header

                  // Mengatur tampilan header
                  decoration: const BoxDecoration(
                    color: Color(0xFF375534), // Warna header
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(28), // Sudut bawah header
                    ),
                  ),

                  alignment: Alignment.center, // Posisi teks di tengah

                  // Memberi jarak sesuai status bar
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),

                  // Judul halaman
                  child: const Text(
                    'Profil',
                    style: TextStyle(
                      color: Colors.white, // Warna teks
                      fontSize: 18, // Ukuran teks
                      fontWeight: FontWeight.bold, // Teks tebal
                    ),
                  ),
                ),

                // Menampilkan tombol kembali jika diperlukan
                if (showBackButton)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 4, // Posisi atas
                    left: 8, // Posisi kiri
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back, // Icon kembali
                        color: Colors.white, // Warna icon
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ), // Kembali ke halaman sebelumnya
                    ),
                  ),

                // Container untuk foto profil
                Positioned(
                  left: 0, // Posisi kiri
                  right: 0, // Posisi kanan
                  bottom: -45, // Membuat foto keluar dari header

                  child: Center(
                    child: Container(
                      width: 90, // Lebar foto
                      height: 90, // Tinggi foto

                      // Mengatur tampilan foto profil
                      decoration: BoxDecoration(
                        color: const Color(0xFFAEC3B0), // Warna background
                        shape: BoxShape.circle, // Bentuk lingkaran
                        border: Border.all(
                          color: Colors.white, // Warna border
                          width: 4, // Ketebalan border
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400, // Warna bayangan
                            blurRadius: 10, // Tingkat blur
                            offset: const Offset(0, 3), // Posisi bayangan
                          ),
                        ],
                      ),

                      // Menampilkan foto profil berbentuk lingkaran
                      child: ClipOval(
                        child: const ProductImage(
                          imagePath: 'assets/profile.jpg', // Path foto profil
                          icon: Icons.person, // Icon pengganti
                          iconSize: 48, // Ukuran icon
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 56), // Jarak header dan nama

            // Menampilkan nama pengguna
            const Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 20, // Ukuran nama
                fontWeight: FontWeight.bold, // Teks tebal
                color: Color(0xFF0F2A1D), // Warna teks
              ),
            ),

            const SizedBox(height: 4), // Jarak nama dan email

            // Menampilkan email pengguna
            const Text(
              'pengguna@email.com',
              style: TextStyle(
                fontSize: 13, // Ukuran teks
                color: Color(0xFF6B9071), // Warna teks
              ),
            ),

            const SizedBox(height: 24), // Jarak email dan statistik

            // Container untuk statistik pengguna
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24, // Jarak kiri dan kanan
              ),
              child: Row(
                children: [
                  // Statistik jumlah pesanan
                  Expanded(
                    child: _buildStat('12', 'Pesanan'),
                  ),

                  const SizedBox(width: 12), // Jarak statistik

                  // Statistik jumlah favorit
                  Expanded(
                    child: _buildStat('5', 'Favorit'),
                  ),

                  const SizedBox(width: 12), // Jarak statistik

                  // Statistik jumlah ulasan
                  Expanded(
                    child: _buildStat('3', 'Ulasan'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24), // Jarak statistik dan menu

            // Container untuk daftar menu
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24, // Jarak kiri dan kanan
              ),
              child: Container(
                // Mengatur tampilan daftar menu
                decoration: BoxDecoration(
                  color: Colors.white, // Warna background
                  borderRadius: BorderRadius.circular(16), // Sudut container
                  border: Border.all(
                    color: const Color(0xFFAEC3B0), // Warna border
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300, // Warna bayangan
                      blurRadius: 10, // Tingkat blur
                      offset: const Offset(0, 3), // Posisi bayangan
                    ),
                  ],
                ),

                // Menyusun menu secara vertikal
                child: Column(
                  children: [
                    // Menu keranjang
                    _buildMenu(
                      Icons.shopping_cart, // Icon keranjang
                      'Keranjang Saya', // Nama menu

                      // Membuka halaman keranjang
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(
                            showBackButton: true, // Menampilkan tombol kembali
                          ),
                        ),
                      ),
                    ),

                    // Menu semua produk
                    _buildMenu(
                      Icons.eco, // Icon produk
                      'Semua Produk', // Nama menu

                      // Membuka halaman semua produk
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllProductsPage(),
                        ),
                      ),
                    ),

                    // Menu favorit
                    _buildMenu(
                      Icons.favorite_border, // Icon favorit
                      'Favorit Saya', // Nama menu
                    ),

                    // Menu pengaturan
                    _buildMenu(
                      Icons.settings, // Icon pengaturan
                      'Pengaturan', // Nama menu
                    ),

                    // Menu bantuan tanpa garis pemisah
                    _buildMenu(
                      Icons.help_outline, // Icon bantuan
                      'Bantuan', // Nama menu
                      showDivider: false, // Menghilangkan divider
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32), // Jarak bawah halaman
          ],
        ),
      ),
    );
  }

  // Membuat kotak statistik
  Widget _buildStat(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14, // Jarak atas dan bawah
      ),

      // Mengatur tampilan kotak statistik
      decoration: BoxDecoration(
        color: Colors.white, // Warna background
        borderRadius: BorderRadius.circular(12), // Sudut kotak
        border: Border.all(
          color: const Color(0xFFAEC3B0), // Warna border
        ),
      ),

      // Menyusun nilai dan label secara vertikal
      child: Column(
        children: [
          // Menampilkan nilai statistik
          Text(
            value, // Nilai statistik
            style: const TextStyle(
              fontSize: 18, // Ukuran angka
              fontWeight: FontWeight.bold, // Teks tebal
              color: Color(0xFF375534), // Warna angka
            ),
          ),

          const SizedBox(height: 2), // Jarak angka dan label

          // Menampilkan label statistik
          Text(
            label, // Nama statistik
            style: const TextStyle(
              fontSize: 12, // Ukuran teks
              color: Color(0xFF6B9071), // Warna teks
            ),
          ),
        ],
      ),
    );
  }

  // Membuat satu baris menu
  Widget _buildMenu(
    IconData icon, // Icon menu
    String title, { // Nama menu
    VoidCallback? onTap, // Fungsi ketika menu ditekan
    bool showDivider = true, // Menentukan divider ditampilkan
  }) {
    // Menyusun menu dan divider
    return Column(
      children: [
        // Membuat baris menu
        ListTile(
          leading: Icon(
            icon, // Icon menu
            color: const Color(0xFF375534), // Warna icon
          ),

          // Menampilkan nama menu
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600, // Ketebalan teks
              color: Color(0xFF0F2A1D), // Warna teks
            ),
          ),

          // Icon panah di sebelah kanan
          trailing: const Icon(
            Icons.chevron_right, // Icon panah
            color: Color(0xFF6B9071), // Warna icon
          ),

          onTap: onTap, // Menjalankan fungsi menu
        ),

        // Menampilkan garis pemisah jika diperlukan
        if (showDivider)
          const Divider(
            height: 1, // Tinggi divider
            color: Color(0xFFE3EED4), // Warna divider
          ),
      ],
    );
  }
}