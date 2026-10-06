import 'package:flutter/material.dart'; // Library Flutter
import 'package:flutter/services.dart'; // Untuk input formatter
import 'package:provider/provider.dart'; // Modul 5 - Provider
import '../models/product.dart'; // Model Product
import '../providers/cartProvider.dart'; // Provider keranjang
import '../widgets/productImage.dart'; // Widget gambar produk

// Halaman detail produk
class ProductDetailPage extends StatefulWidget {
  final Product product; // Data produk yang dipilih

  const ProductDetailPage({
    super.key, // Key widget
    required this.product, // Produk wajib dikirim
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState(); // Membuat state
}

// Membuat state pada ProductDetailPage
class _ProductDetailPageState extends State<ProductDetailPage> {
  // Controller untuk input jumlah produk
  final TextEditingController _qtyController =
      TextEditingController(text: '1');

  @override
  void dispose() {
    _qtyController.dispose(); // Menghapus controller saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product; // Mengambil data produk

    // Memantau perubahan data pada CartProvider
    context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4), // Warna background

      body: Column(
        children: [
          // Area utama berisi gambar dan informasi produk
          Expanded(
            // Stack untuk menumpuk beberapa widget
            child: Stack(
              children: [
                // Gambar produk di bagian atas
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 320,
                  child: ProductImage(
                    imagePath: product.imagePath, // Path gambar
                    icon: product.icon, // Icon pengganti gambar
                    iconSize: 90, // Ukuran icon
                  ),
                ),

                // Panel informasi produk
                Positioned(
                  top: 290,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white, // Warna panel
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24), // Sudut atas membulat
                      ),
                    ),

                    // Agar isi dapat di-scroll
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama produk
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2A1D),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Rating dan stok produk
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),

                              // Nilai rating
                              Text(
                                '${product.rating}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B9071),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Menampilkan jumlah stok
                              Text(
                                product.stock > 0
                                    ? 'Stok: ${product.stock}'
                                    : 'Stok habis',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: product.stock > 0
                                      ? const Color(0xFF6B9071)
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Harga produk
                          Text(
                            formatRupiah(product.price),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF375534),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Judul deskripsi
                          const Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2A1D),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Deskripsi produk
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

                // Tombol kembali di pojok kiri atas
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 16,
                  child: GestureDetector(
                    // Kembali ke halaman sebelumnya
                    onTap: () => Navigator.pop(context),

                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF0F2A1D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bar bawah untuk jumlah dan tombol keranjang
          Container(
            padding: EdgeInsets.fromLTRB(
              24,
              14,
              24,
              14 + MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),

            // Menyusun jumlah dan tombol secara horizontal
            child: Row(
              children: [
                // Label jumlah
                const Text(
                  'Jumlah',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2A1D),
                  ),
                ),

                const SizedBox(width: 12),

                // Input jumlah produk
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _qtyController, // Controller input
                    keyboardType: TextInputType.number, // Keyboard angka
                    textAlign: TextAlign.center, // Teks di tengah

                    // Membatasi input hanya angka dan maksimal 3 digit
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],

                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFAEC3B0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFAEC3B0),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Tombol tambah ke keranjang
                Expanded(
                  child: ElevatedButton.icon(
                    // Tombol aktif jika stok masih tersedia
                    onPressed: product.stock > 0
                        ? () {
                            // Mengubah input jumlah menjadi integer
                            final qty =
                                int.tryParse(_qtyController.text) ?? 0;

                            // Mengambil CartProvider untuk menambahkan produk
                            final success = context
                                .read<CartProvider>()
                                .addMultiple(product, qty);

                            // Menampilkan hasil proses
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? '$qty x ${product.name} ditambahkan ke keranjang'
                                      : 'Jumlah melebihi stok yang tersedia',
                                ),
                              ),
                            );
                          }
                        : null,

                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 18,
                    ),

                    label: const Text('Tambah'),

                    // Tampilan tombol
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF375534),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      minimumSize: const Size(
                        double.infinity,
                        44,
                      ),
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