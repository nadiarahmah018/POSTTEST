import 'package:flutter/material.dart'; // Library Flutter
import 'package:provider/provider.dart'; // Modul 5 - Provider
import '../providers/cartProvider.dart'; // Provider keranjang
import '../widgets/productCard.dart'; // Widget kartu produk
import 'allProductPage.dart'; // Halaman semua produk
import 'cartPage.dart'; // Halaman keranjang
import 'profilePage.dart'; // Halaman profil

// Halaman beranda
class HomePage extends StatefulWidget {
  const HomePage({
    super.key, // Key widget
  });

  @override
  State<HomePage> createState() => _HomePageState(); // Membuat state
}

// Membuat state pada HomePage
class _HomePageState extends State<HomePage> {
  String _searchQuery = ''; // State untuk menyimpan pencarian

  // Controller untuk mengatur isi TextField
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose(); // Menghapus controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah sedang melakukan pencarian
    final bool isSearching = _searchQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4), // Warna background

      // AppBar halaman
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3EED4),
        elevation: 0,

        // Logo dan nama aplikasi
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF375534),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.eco,
                color: Colors.white,
                size: 20,
              ),
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

        // Tombol pada AppBar
        actions: [
          // Menampilkan jumlah produk dalam keranjang
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return GestureDetector(
                // Membuka halaman keranjang
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const CartPage(showBackButton: true),
                    ),
                  );
                },

                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFAEC3B0),
                    ),
                  ),

                  child: Row(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        size: 18,
                        color: Color(0xFF375534),
                      ),

                      const SizedBox(width: 6),

                      // Badge jumlah produk
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF375534),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${cart.totalItemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Tombol profil
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              // Membuka halaman profil
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProfilePage(showBackButton: true),
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

      // Isi halaman
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  20,
                  24,
                  20,
                ),
                child: TextField(
                  controller: _searchController,

                  // Menyimpan teks pencarian ke state
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.trim().toLowerCase();
                    });
                  },

                  decoration: InputDecoration(
                    hintText: 'Cari tanaman hias...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF6B9071),
                    ),

                    // X saat mengetik, icon search saat kosong
                    suffixIcon: isSearching
                        ? IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 22,
                              color: Color(0xFF6B9071),
                            ),

                            // Menghapus pencarian
                            onPressed: () {
                              _searchController.clear();

                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.search,
                              size: 24,
                              color: Color(0xFF6B9071),
                            ),
                          ),

                    filled: true,
                    fillColor: Colors.white,

                    // Border TextField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        color: Color(0xFFAEC3B0),
                      ),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        color: Color(0xFFAEC3B0),
                      ),
                    ),

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                ),
              ),

              // Jika sedang mencari, tampilkan hasil pencarian
              if (isSearching)
                _buildSearchResults()

              // Jika tidak mencari, tampilkan halaman normal
              else ...[
                // Banner promosi
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SizedBox(
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildBanner(
                            'Diskon 20%',
                            'Tanaman indoor',
                            Icons.eco,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _buildBanner(
                            'Gratis Ongkir',
                            'Min. Rp100.000',
                            Icons.local_shipping,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _buildBanner(
                            'Koleksi Baru',
                            'Gantung minimalis',
                            Icons.spa,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Judul kategori
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

                // Daftar kategori horizontal
                SizedBox(
                  height: 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      children: [
                        _buildCategoryChip(
                          'Semua',
                          isSelected: true,
                        ),

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

                // Produk terlaris dan semua produk
                Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    // Produk yang masih memiliki stok
                    final allProducts = cart.products
                        .where((p) => p.stock > 0)
                        .toList();

                    // Mengambil 3 produk pertama
                    final popular = cart.products.take(3).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul produk terlaris dan tombol lihat semua
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Produk Terlaris',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F2A1D),
                                ),
                              ),

                              // Tombol menuju semua produk
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AllProductsPage(),
                                    ),
                                  );
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.transparent,
                                  foregroundColor:
                                      const Color(0xFF375534),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                ),

                                child: const Text(
                                  'Lihat Semua',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Menampilkan 3 produk secara horizontal
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < popular.length;
                                  i++) ...[
                                // Jarak antar kartu
                                if (i > 0)
                                  const SizedBox(width: 14),

                                Expanded(
                                  child: ProductCardHorizontal(
                                    product: popular[i],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Judul semua produk
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
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

                        // Grid semua produk
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: GridView.count(
                            crossAxisCount: 2, // Dua kolom
                            crossAxisSpacing: 14, // Jarak kolom
                            mainAxisSpacing: 14, // Jarak baris
                            childAspectRatio: 0.68,
                            shrinkWrap: true,

                            // Scroll menggunakan SingleChildScrollView
                            physics:
                                const NeverScrollableScrollPhysics(),

                            // Membuat kartu produk
                            children: allProducts
                                .map(
                                  (p) => ProductCardGrid(
                                    product: p,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Menampilkan hasil pencarian
  Widget _buildSearchResults() {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        // Memfilter produk berdasarkan nama
        final results = cart.products.where((product) {
          return product.stock > 0 &&
              product.name
                  .toLowerCase()
                  .contains(_searchQuery);
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul dan jumlah hasil pencarian
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Hasil Pencarian (${results.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F2A1D),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Menampilkan hasil pencarian
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: results.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 40,
                      ),
                      child: Center(
                        child: Text(
                          'Produk tidak ditemukan',
                          style: TextStyle(
                            color: Color(0xFF6B9071),
                          ),
                        ),
                      ),
                    )
                  : GridView.count(
                      crossAxisCount: 2, // Dua kolom
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.68,
                      shrinkWrap: true,

                      // Scroll mengikuti SingleChildScrollView
                      physics:
                          const NeverScrollableScrollPhysics(),

                      // Membuat kartu dari hasil pencarian
                      children: results
                          .map(
                            (p) => ProductCardGrid(
                              product: p,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        );
      },
    );
  }

  // Membuat banner promosi
  Widget _buildBanner(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF375534),
        borderRadius: BorderRadius.circular(16),
      ),

      // Stack untuk menempatkan icon dekorasi
      child: Stack(
        children: [
          // Icon dekorasi di pojok
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              icon,
              size: 56,
              color: Colors.white.withOpacity(0.15),
            ),
          ),

          // Isi banner
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center,
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
                  style: const TextStyle(
                    color: Color(0xFFE3EED4),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Membuat tombol kategori
  Widget _buildCategoryChip(
    String label, {
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        // Warna berbeda untuk kategori yang dipilih
        color: isSelected
            ? const Color(0xFF375534)
            : Colors.white,

        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          color: isSelected
              ? const Color(0xFF375534)
              : const Color(0xFFAEC3B0),
        ),
      ),

      // Nama kategori
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isSelected
              ? Colors.white
              : const Color(0xFF0F2A1D),
        ),
      ),
    );
  }
}