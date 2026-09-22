import 'package:flutter/material.dart';
import 'widgets/productCard.dart';


// Fungsi utama untuk menjalankan aplikasi Flutter
void main() {
  runApp(const MainApp());
}

// Widget utama aplikasi
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp digunakan sebagai dasar/konfigurasi utama aplikasi
    return MaterialApp(
      // mengatur tema aplikasi
      theme: ThemeData(
        // menggunakan font Inter
        fontFamily: 'Inter',

        // menentukan warna utama aplikasi
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF375534),
        ),
      ),

      // menghilangkan tulisan DEBUG pada pojok kanan atas
      debugShowCheckedModeBanner: false,

      // menentukan halaman pertama yang ditampilkan
      home: const HomePage(),
    );
  }
}


// menyimpan index menu yang sedang dipilih pada NavigationBar
int _currentIndex = 0;


// halaman utama aplikasi Myplants
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold merupakan struktur dasar halaman aplikasi, menyediakan AppBar, body, dan NavigationBar
    return Scaffold(

      // Mengatur warna background halaman
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

              // mengatur warna dan bentuk sudut logo
              decoration: BoxDecoration(
                color: const Color(0xFF375534),
                borderRadius: BorderRadius.circular(10),
              ),

              // Icon menampilkan ikon tanaman
              child: const Icon(
                Icons.eco,
                color: Colors.white,
                size: 20,
              ),
            ),

            // memberikan jarak horizontal antara logo dan nama aplikasi
            const SizedBox(width: 10),

            // Text menampilkan nama aplikasi
            const Text(
              'Myplants',
              style: TextStyle( // properti TextStyle untuk mengatur fontSize, fontWeight, color, textAlign
                color: Color(0xFF0F2A1D),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),

        // actions berisi widget yang berada di sebelah kanan AppBar
        actions: [

          // Container fungsinya untuk membungkus widget untuk membuat tampilan tombol keranjang
          Container(
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

            // Row menyusun ikon keranjang dan jumlah barang
            child: Row(
              children: [

                // Icon keranjang belanja
                const Icon(
                  Icons.shopping_cart,
                  size: 18,
                  color: Color(0xFF375534),
                ),

                // Memberikan jarak antara ikon dan angka
                const SizedBox(width: 6),

                // Container untuk menampilkan jumlah barang
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFF375534),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  // menampilkan jumlah barang di keranjang
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

          // Padding memberikan ruang/jarak pada bagian kanan ikon profil
          Padding(
            padding: const EdgeInsets.only(right: 20),

            // Container sebagai background ikon profil
            child: Container(
              width: 36,
              height: 36,

              decoration: BoxDecoration(
                color: const Color(0xFFAEC3B0),
                borderRadius: BorderRadius.circular(18),
              ),

              // Icon profil pengguna
              child: const Icon(
                Icons.person,
                color: Color(0xFF0F2A1D),
                size: 20,
              ),
            ),
          ),
        ],
      ),


      // SafeArea memastikan isi halaman tidak tertutup area sistem
      body: SafeArea(

        // SingleChildScrollView membuat halaman dapat di-scroll
        child: SingleChildScrollView(

          // Column menyusun seluruh isi halaman secara vertikal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // Padding memberikan jarak pada search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  20,
                  24,
                  20,
                ),

                // TextField adalah widget untuk input text, digunakan sebagai kolom pencarian
                child: TextField(
                  decoration: InputDecoration(

                    // Teks petunjuk pada search bar
                    hintText: 'Cari tanaman hias...',

                    hintStyle: const TextStyle(
                      color: Color(0xFF6B9071),
                    ),

                    // Ikon pencarian pada sisi kanan
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.search,
                        size: 24,
                        color: Color(0xFF6B9071),
                      ),
                    ),

                    // mengatur bentuk border search bar
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        color: Color(0xFFAEC3B0),
                      ),
                    ),

                    // Border ketika TextField aktif
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        color: Color(0xFFAEC3B0),
                      ),
                    ),

                    // mengatur jarak teks dengan border
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

                // SizedBox menentukan tinggi banner
                child: SizedBox(
                  height: 120,

                  // Row menyusun tiga banner secara horizontal
                  child: Row(
                    children: [

                      // Expanded membagi ruang secara proporsional
                      Expanded(
                        child: _buildBanner(
                          'Diskon 20%',
                          'Tanaman indoor',
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _buildBanner(
                          'Gratis Ongkir',
                          'Min. Rp100.000',
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _buildBanner(
                          'Koleksi Baru',
                          'Gantung minimalis',
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              // memberikan jarak sebelum bagian kategori
              const SizedBox(height: 24),

              // Judul bagian kategori
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


              // SizedBox menentukan tinggi area kategori
              SizedBox(
                height: 40,

                // SingleChildScrollView memungkinkan kategori digeser horizontal
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),

                  // Row menyusun kategori secara horizontal
                  child: Row(
                    children: [

                      // Kategori yang sedang dipilih
                      _buildCategoryChip(
                        'Semua',
                        isSelected: true,
                      ),

                      const SizedBox(width: 10),

                      // Kategori lainnya
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


              // Row berisi judul produk dan tombol Lihat Semua
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Judul Produk Terlaris
                    const Text(
                      'Produk Terlaris',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F2A1D),
                      ),
                    ),

                    // Tombol untuk melihat seluruh produk
                    ElevatedButton(
                      onPressed: () {},

                      // Mengatur tampilan tombol
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: const Color(0xFF375534),
                        elevation: 0,
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


              // Menampilkan produk terlaris secara horizontal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    // Expanded membagi lebar kartu secara merata
                    Expanded(
                      child: ProductCardHorizontal(
                        name: 'Monstera Deliciosa',
                        price: 'Rp85.000',
                        rating: 4.8,
                        icon: Icons.eco,
                      ),
                    ),

                    SizedBox(width: 14),

                    Expanded(
                      child: ProductCardHorizontal(
                        name: 'Lidah Mertua',
                        price: 'Rp45.000',
                        rating: 4.6,
                        icon: Icons.grass,
                      ),
                    ),

                    SizedBox(width: 14),

                    Expanded(
                      child: ProductCardHorizontal(
                        name: 'Kaktus Mini',
                        price: 'Rp25.000',
                        rating: 4.5,
                        icon: Icons.park,
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 32),


              // Judul bagian seluruh produk
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Text(
                  'Semua Produk',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2A1D),
                  ),
                ),
              ),

              const SizedBox(height: 14),


              // Padding memberikan jarak pada bagian grid produk
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),

                // GridView digunakan untuk menampilkan produk berbentuk grid
                child: GridView.count(

                  // Membuat 2 kolom produk
                  crossAxisCount: 2,

                  // Jarak antar kolom
                  crossAxisSpacing: 14,

                  // Jarak antar baris
                  mainAxisSpacing: 14,

                  // Mengatur perbandingan ukuran kartu
                  childAspectRatio: 0.68,

                  // Grid mengikuti tinggi kontennya
                  shrinkWrap: true,

                  // Scroll grid dimatikan karena sudah menggunakan
                  // SingleChildScrollView pada halaman utama
                  physics: const NeverScrollableScrollPhysics(),

                  children: const [

                    // Custom widget kartu produk
                    ProductCardGrid(
                      name: 'Monstera Deliciosa',
                      price: 'Rp85.000',
                      rating: 4.8,
                      icon: Icons.eco,
                    ),

                    ProductCardGrid(
                      name: 'Lidah Mertua',
                      price: 'Rp45.000',
                      rating: 4.6,
                      icon: Icons.grass,
                    ),

                    ProductCardGrid(
                      name: 'Kaktus Mini',
                      price: 'Rp25.000',
                      rating: 4.5,
                      icon: Icons.park,
                    ),

                    ProductCardGrid(
                      name: 'Sirih Gading',
                      price: 'Rp35.000',
                      rating: 4.7,
                      icon: Icons.local_florist,
                    ),

                    ProductCardGrid(
                      name: 'Palem Kuning',
                      price: 'Rp120.000',
                      rating: 4.4,
                      icon: Icons.forest,
                    ),

                    ProductCardGrid(
                      name: 'Aglonema',
                      price: 'Rp65.000',
                      rating: 4.9,
                      icon: Icons.spa,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),


      // NavigationBar digunakan sebagai menu navigasi bagian bawah
      bottomNavigationBar: NavigationBar(

        // Mengatur warna background navigasi
        backgroundColor: Colors.white,

        // Menentukan menu yang sedang aktif
        selectedIndex: _currentIndex,

        // Daftar menu navigasi
        destinations: const [

          // Menu Beranda
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),

          // Menu Keranjang
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),

          // Menu Profil
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }


  // Fungsi untuk membuat widget banner agar tidak perlu menulis kode berulang
  Widget _buildBanner(String title, String subtitle) {

    // Container digunakan sebagai bentuk dasar banner
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF375534),
        borderRadius: BorderRadius.circular(16),
      ),

      // Column menyusun judul dan subtitle secara vertikal
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          // Menampilkan judul banner
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          // Menampilkan subtitle banner
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFFE3EED4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }


  // Fungsi untuk membuat tombol kategori
  Widget _buildCategoryChip(
    String label, {
    bool isSelected = false,
  }) {

    // Container menjadi bentuk dasar tombol kategori
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),

      // Mengubah warna berdasarkan status pilihan
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF375534)
            : Colors.white,

        // Membuat sudut tombol melengkung
        borderRadius: BorderRadius.circular(30),

        // Mengatur warna border berdasarkan status pilihan
        border: Border.all(
          color: isSelected
              ? const Color(0xFF375534)
              : const Color(0xFFAEC3B0),
        ),
      ),

      // Menampilkan nama kategori
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,

          // Warna teks berubah jika kategori dipilih
          color: isSelected
              ? Colors.white
              : const Color(0xFF0F2A1D),
        ),
      ),
    );
  }
}