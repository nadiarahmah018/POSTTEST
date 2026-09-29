import 'package:flutter/material.dart';
import 'pages/cartPage.dart';
import 'pages/homePage.dart';
import 'pages/profilePage.dart';

// Fungsi utama untuk menjalankan aplikasi Flutter
void main() {
  runApp(const MainApp());
}

// Widget utama aplikasi
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  // Menyediakan Navigator, tema, dan halaman awal (home)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF375534)),
      ),
      debugShowCheckedModeBanner: false,

      // halaman pertama sekarang MainPage yang memiliki NavigationBar
      home: const MainPage(),
    );
  }
}

// MainPage berisi NavigationBar dan menampilkan halaman sesuai menu yang dipilih.
// Dibuat StatefulWidget karena index menu berubah saat pengguna menekan menu.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // menyimpan index menu yang sedang dipilih pada NavigationBar
  int _currentIndex = 0;

  // daftar halaman, urutannya sama dengan urutan menu NavigationBar
  final List<Widget> _pages = const [
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack menampilkan satu halaman sesuai index, tapi menjaga state halaman lain
      // (misalnya isi jumlah di keranjang tidak hilang saat pindah menu)
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // NavigationBar digunakan sebagai menu navigasi bagian bawah
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE3EED4),
        selectedIndex: _currentIndex,

        // dipanggil saat menu ditekan; setState membuat tampilan diperbarui
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFF375534)),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart, color: Color(0xFF375534)),
            label: 'Keranjang',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFF375534)),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}