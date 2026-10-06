import 'package:flutter/material.dart'; // Library Flutter
import 'package:provider/provider.dart'; // Modul 5 - Provider
import '../models/product.dart'; // Model Product
import '../providers/cartProvider.dart'; // Provider keranjang

// Halaman konfirmasi setelah checkout
class CheckoutSuccessPage extends StatelessWidget {
  final int total; // Total belanja dari CartPage

  const CheckoutSuccessPage({
    super.key, // Key widget
    required this.total, // Total wajib dikirim
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4), // Warna background

      // Menempatkan isi halaman di tengah
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Posisi vertikal tengah
          children: [
            // Lingkaran berisi ikon centang
            Container(
              width: 90, // Lebar lingkaran
              height: 90, // Tinggi lingkaran
              decoration: const BoxDecoration(
                color: Color(0xFF375534), // Warna lingkaran
                shape: BoxShape.circle, // Bentuk lingkaran
              ),
              child: const Icon(
                Icons.check, // Ikon centang
                color: Colors.white, // Warna ikon
                size: 48, // Ukuran ikon
              ),
            ),

            const SizedBox(height: 20), // Jarak

            // Label total
            const Text(
              'Total',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B9071),
              ),
            ),

            const SizedBox(height: 4), // Jarak

            // Menampilkan total belanja
            Text(
              formatRupiah(total),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2A1D),
              ),
            ),

            const SizedBox(height: 32), // Jarak sebelum tombol

            // Mengatur lebar tombol
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: SizedBox(
                width: double.infinity,

                // Tombol kembali
                child: ElevatedButton(
                  onPressed: () {
                    // Mengosongkan keranjang setelah checkout
                    context.read<CartProvider>().checkout();

                    // Kembali ke halaman sebelumnya
                    Navigator.pop(context);
                  },

                  // Tampilan tombol
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF375534),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(
                      double.infinity,
                      48,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  child: const Text('Kembali'), // Teks tombol
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}