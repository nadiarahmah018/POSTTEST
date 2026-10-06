import 'package:flutter/material.dart'; // Library Flutter
import 'package:provider/provider.dart'; // State management
import 'pages/cartPage.dart'; // Halaman keranjang
import 'pages/homePage.dart'; // Halaman beranda
import 'pages/profilePage.dart'; // Halaman profil
import 'providers/cartProvider.dart'; // Provider keranjang

// Fungsi utama aplikasi
void main() {
  runApp( // Menjalankan aplikasi
    MultiProvider( // Menyediakan Provider
      providers: [ // Daftar Provider
        ChangeNotifierProvider( // Provider yang dapat berubah
          create: (_) => CartProvider(), // Membuat CartProvider
        ),
      ],
      child: const MainApp(), // Widget utama
    ),
  );
}

// Widget utama aplikasi
class MainApp extends StatelessWidget {
  const MainApp({super.key}); // Constructor

  @override
  Widget build(BuildContext context) { // Membuat tampilan
    return MaterialApp( // Widget utama Flutter
      theme: ThemeData( // Mengatur tema
        fontFamily: 'Inter', // Mengatur font
        colorScheme: ColorScheme.fromSeed( // Membuat skema warna
          seedColor: const Color(0xFF375534), // Warna utama
        ),
      ),
      debugShowCheckedModeBanner: false, // Menghilangkan DEBUG
      home: const MainPage(), // Halaman awal
    );
  }
}

// Halaman utama dengan navigasi
class MainPage extends StatefulWidget {
  const MainPage({super.key}); // Constructor

  @override
  State<MainPage> createState() => _MainPageState(); // Membuat state
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Index menu aktif

  final List<Widget> _pages = const [ // Daftar halaman
    HomePage(), // Halaman beranda
    CartPage(), // Halaman keranjang
    ProfilePage(), // Halaman profil
  ];

  @override
  Widget build(BuildContext context) { // Membuat tampilan
    return Scaffold( // Struktur halaman

      // Menampilkan halaman sesuai index
      body: IndexedStack(
        index: _currentIndex, // Index halaman aktif
        children: _pages, // Daftar halaman
      ),

      // Membuat navigasi bawah
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white, // Warna background
        indicatorColor: const Color(0xFFE3EED4), // Warna indikator
        selectedIndex: _currentIndex, // Menu aktif

        // Saat menu dipilih
        onDestinationSelected: (index) {
          setState(() { // Memperbarui tampilan
            _currentIndex = index; // Mengubah index
          });
        },

        // Daftar menu
        destinations: const [

          // Menu beranda
          NavigationDestination(
            icon: Icon(Icons.home_outlined), // Icon tidak aktif
            selectedIcon: Icon( // Icon aktif
              Icons.home, // Icon beranda
              color: Color(0xFF375534), // Warna icon
            ),
            label: 'Beranda', // Nama menu
          ),

          // Menu keranjang
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined), // Icon tidak aktif
            selectedIcon: Icon( // Icon aktif
              Icons.shopping_cart, // Icon keranjang
              color: Color(0xFF375534), // Warna icon
            ),
            label: 'Keranjang', // Nama menu
          ),

          // Menu profil
          NavigationDestination(
            icon: Icon(Icons.person_outline), // Icon tidak aktif
            selectedIcon: Icon( // Icon aktif
              Icons.person, // Icon profil
              color: Color(0xFF375534), // Warna icon
            ),
            label: 'Profil', // Nama menu
          ),
        ],
      ),
    );
  }
}