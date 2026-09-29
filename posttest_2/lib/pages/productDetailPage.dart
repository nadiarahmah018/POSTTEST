import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../widgets/productImage.dart';

// Halaman detail produk, dibuka lewat Navigator.push dari kartu produk
class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // Controller untuk membaca isi TextField jumlah produk
  final TextEditingController _qtyController = TextEditingController(text: '1');

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4),

      body: Column(
        children: [
          // Expanded: area atas (gambar + konten) mengisi sisa layar di atas bar bawah
          Expanded(
            // Stack menumpuk gambar, tombol kembali, dan panel informasi
            child: Stack(
              children: [
                // Lapisan 1: gambar produk di bagian atas
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 320,
                  child: ProductImage(
                    imagePath: product.imagePath,
                    icon: product.icon,
                    iconSize: 90,
                  ),
                ),

                // Lapisan 2: panel putih berisi informasi produk
                Positioned(
                  top: 290,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2A1D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 18, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${product.rating}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B9071),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            product.price,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF375534),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2A1D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description.isEmpty
                                ? 'Belum ada deskripsi untuk produk ini.'
                                : product.description,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFF375534),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),

                // Lapisan 3 (paling atas): tombol kembali di pojok kiri atas
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 16,
                  child: GestureDetector(
                    // Navigator.pop: menutup halaman ini dan kembali ke halaman sebelumnya
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Color(0xFF0F2A1D)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bar bawah: input jumlah + tombol tambah ke keranjang
          Container(
            padding: EdgeInsets.fromLTRB(
              24,
              14,
              24,
              14 + MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              // BoxShadow dengan offset negatif agar bayangan muncul di sisi atas
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Text(
                  'Jumlah',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2A1D),
                  ),
                ),
                const SizedBox(width: 12),

                // TextField khusus angka
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _qtyController,
                    keyboardType: TextInputType.number, // keyboard angka
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // hanya boleh 0-9
                      LengthLimitingTextInputFormatter(3), // maksimal 3 digit
                    ],
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFAEC3B0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFAEC3B0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final qty = int.tryParse(_qtyController.text) ?? 0;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            qty > 0
                                ? '$qty x ${product.name} ditambahkan ke keranjang'
                                : 'Jumlah harus lebih dari 0',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart, size: 18),
                    label: const Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF375534),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}