import 'package:flutter/material.dart';
import 'widgets/productCard.dart';

void main() {
  runApp(const MainApp());
}

// MaterialApp -> widget wrapper utama dari aplikasi (Modul 2 - MaterialApp)
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme -> menentukan aturan visual umum aplikasi
      theme: ThemeData(
        fontFamily: 'Inter',
        // colorScheme -> dibuat dari seedColor, dipakai sesuai contoh di modul
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF375534)),
      ),
      // debugShowCheckedModeBanner -> menonaktifkan tulisan debug di pojok kanan atas
      debugShowCheckedModeBanner: false,
      // home -> menentukan halaman yang ditampilkan
      home: const HomePage(),
    );
  }
}

// Variabel biasa (bukan widget) untuk menyimpan index navigasi yang sedang aktif
int _currentIndex = 0;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold -> struktur dasar halaman aplikasi Mobile (Modul 2 - Scaffold)
    // properti dasarnya: backgroundColor, body, bottomNavigationBar
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4), // warna cream dari palet toko
      // body -> berisi konten halaman utama
      body: SafeArea(
        // SafeArea -> memastikan child tidak tertutup area yang tertutup perangkat
        // (misal notch atau status bar)
        child: Column(
          children: [
            // ================= Search Bar =================
            // Padding -> memberi ruang antar child, pakai EdgeInsets.symmetric
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              // TextField -> widget untuk input text, di sini dipakai untuk
              // mencari tanaman
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari tanaman hias...',
                  hintStyle: const TextStyle(color: Color(0xFF6B9071)),
                  // suffixIcon -> menampilkan icon di ujung kanan TextField
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    // Icon -> menampilkan ikon pencarian
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: const Color(0xFF6B9071),
                    ),
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

            // ================= Konten yang bisa di-scroll =================
            // Expanded -> memaksa widget anak (child) mengisi sisa ruang yang
            // tersedia di dalam Column
            Expanded(
              // SingleChildScrollView -> agar konten bisa discroll, hanya
              // menggunakan 1 child
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  // Column -> menyusun beberapa ProductCard dari atas ke bawah
                  child: Column(
                    children: [
                      // ProductCard -> widget custom dari file productCard.dart,
                      // setiap produk diisi data yang berbeda lewat parameter
                      ProductCard(
                        name: 'Monstera Deliciosa',
                        description: 'Tanaman hias indoor',
                        price: 'Rp85.000',
                      ),
                      // SizedBox -> memberi jarak vertikal antar card
                      SizedBox(height: 28),
                      ProductCard(
                        name: 'Lidah Mertua',
                        description: 'Mudah dirawat, cocok untuk indoor',
                        price: 'Rp45.000',
                      ),
                      SizedBox(height: 28),
                      ProductCard(
                        name: 'Kaktus Mini',
                        description: 'Tanaman hias meja kerja',
                        price: 'Rp25.000',
                      ),
                      SizedBox(height: 28),
                      ProductCard(
                        name: 'Sirih Gading',
                        description: 'Tanaman rambat gantung',
                        price: 'Rp35.000',
                      ),
                      SizedBox(height: 28),
                      ProductCard(
                        name: 'Palem Kuning',
                        description: 'Tanaman hias outdoor',
                        price: 'Rp120.000',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar -> widget dibawah yang fungsinya sebagai navigasi
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,

        selectedIndex: _currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}