import 'package:flutter/material.dart'; // Library Flutter
import 'package:provider/provider.dart'; // Modul 5 - Provider
import '../models/product.dart'; // Model Product
import '../providers/cartProvider.dart'; // Provider keranjang
import '../widgets/cartProductCard.dart'; // Widget kartu produk
import 'checkoutSuccessPage.dart'; // Halaman sukses checkout

// Halaman keranjang
class CartPage extends StatefulWidget {
  final bool showBackButton; // Menentukan tombol kembali ditampilkan

  const CartPage({
    super.key, // Key widget
    this.showBackButton = false, // Default tanpa tombol kembali
  });

  @override
  State<CartPage> createState() => _CartPageState(); // Membuat state
}

// Membuat state pada CartPage
class _CartPageState extends State<CartPage> {
  String _query = ''; // State untuk pencarian produk

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4), // Warna background

      // AppBar halaman keranjang
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3EED4),
        elevation: 0,
        automaticallyImplyLeading: false,

        // Tombol kembali jika diperlukan
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF0F2A1D),
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,

        // Judul halaman
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Color(0xFF0F2A1D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      // Memantau perubahan data keranjang
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          // Mengambil produk yang ada di keranjang dan sesuai pencarian
          final cartProducts = cart.products.where((p) {
            final qty = cart.quantityOf(p); // Mengambil jumlah produk

            return qty > 0 &&
                p.name.toLowerCase().contains(
                      _query.toLowerCase(),
                    );
          }).toList();

          // Stack untuk menumpuk daftar dan bar total
          return Stack(
            children: [
              // Bagian daftar produk
              Column(
                children: [
                  // Search bar keranjang
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: TextField(
                      // Mengubah kata pencarian
                      onChanged: (value) {
                        setState(() => _query = value);
                      },

                      decoration: InputDecoration(
                        hintText: 'Cari di keranjang...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF6B9071),
                        ),

                        // Icon pencarian
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.search,
                            size: 24,
                            color: Color(0xFF6B9071),
                          ),
                        ),

                        filled: true,
                        fillColor: Colors.white,

                        // Border normal
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Color(0xFFAEC3B0),
                          ),
                        ),

                        // Border saat aktif
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Color(0xFFAEC3B0),
                          ),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),

                  // Area daftar produk
                  Expanded(
                    child: cartProducts.isEmpty
                        ? Center(
                            child: Text(
                              // Pesan jika keranjang kosong atau produk tidak ditemukan
                              cart.totalItemCount == 0
                                  ? 'Keranjang masih kosong'
                                  : 'Produk tidak ditemukan',
                              style: const TextStyle(
                                color: Color(0xFF6B9071),
                              ),
                            ),
                          )
                        : ListView.builder(
                            // Jarak bawah agar tidak tertutup bar total
                            padding: const EdgeInsets.fromLTRB(
                              24,
                              0,
                              24,
                              110,
                            ),

                            itemCount: cartProducts.length,

                            // Membuat setiap kartu produk
                            itemBuilder: (context, index) {
                              final product = cartProducts[index];
                              final qty = cart.quantityOf(product);

                              // Membuat kartu produk di keranjang
                              return CartProductCard(
                                product: product, // Data produk
                                quantity: qty, // Jumlah produk
                                maxQuantity: product.stock + qty, // Batas jumlah

                                // Mengubah jumlah produk
                                onQuantityChanged: (newQty) {
                                  context
                                      .read<CartProvider>()
                                      .changeQuantity(
                                        product,
                                        newQty,
                                      );
                                },

                                // Menghapus produk dari keranjang
                                onRemove: () {
                                  context
                                      .read<CartProvider>()
                                      .removeFromCart(product);
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),

              // Bar total di bagian bawah
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,

                    // Bayangan pada bar total
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
                      // Informasi total belanja
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B9071),
                            ),
                          ),

                          // Menampilkan total harga
                          Text(
                            formatRupiah(cart.grandTotal),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2A1D),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),

                      // Tombol checkout
                      Expanded(
                        child: ElevatedButton.icon(
                          // Aktif jika total belanja lebih dari 0
                          onPressed: cart.grandTotal > 0
                              ? () {
                                  // Menyimpan total sebelum pindah halaman
                                  final total = cart.grandTotal;

                                  // Membuka halaman sukses checkout
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CheckoutSuccessPage(
                                        total: total,
                                      ),
                                    ),
                                  );
                                }
                              : null,

                          icon: const Icon(
                            Icons.shopping_cart,
                            size: 18,
                          ),

                          label: const Text('Checkout'),

                          // Tampilan tombol checkout
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
              ),
            ],
          );
        },
      ),
    );
  }
}