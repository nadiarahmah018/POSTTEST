import 'package:flutter/material.dart'; // Library Flutter
import 'package:flutter/services.dart'; // Input formatter
import '../models/product.dart'; // Model Product
import 'productImage.dart'; // Widget gambar produk

// Widget kartu produk di keranjang
class CartProductCard extends StatefulWidget {
  final Product product; // Data produk
  final int quantity; // Jumlah produk
  final int maxQuantity; // Jumlah maksimal
  final ValueChanged<int> onQuantityChanged; // Callback jumlah
  final VoidCallback onRemove; // Callback hapus

  // Constructor CartProductCard
  const CartProductCard({
    super.key, // Key widget
    required this.product, // Produk wajib diisi
    required this.quantity, // Jumlah wajib diisi
    required this.maxQuantity, // Maksimal wajib diisi
    required this.onQuantityChanged, // Callback jumlah
    required this.onRemove, // Callback hapus
  });

  @override
  State<CartProductCard> createState() =>
      _CartProductCardState(); // Membuat state CartProductCard
}

// Membuat state pada CartProductCard
class _CartProductCardState extends State<CartProductCard> {
  late final TextEditingController quantityController; // Controller jumlah

  @override
  void initState() {
    super.initState(); // Menjalankan initState parent
    quantityController = TextEditingController(
      text: '${widget.quantity}', // Nilai awal jumlah
    );
  }

  @override
  void didUpdateWidget(covariant CartProductCard oldWidget) {
    super.didUpdateWidget(oldWidget); // Menjalankan fungsi parent

    // Menyamakan nilai TextField dengan jumlah terbaru
    if (oldWidget.quantity != widget.quantity &&
        quantityController.text != '${widget.quantity}') {
      quantityController.text = '${widget.quantity}'; // Mengubah teks jumlah
    }
  }

  @override
  void dispose() {
    quantityController.dispose(); // Membersihkan controller
    super.dispose(); // Menjalankan dispose parent
  }

  // Memvalidasi jumlah produk
  void _updateQuantity(String value) {
    final parsed = int.tryParse(value); // Mengubah teks menjadi angka

    if (parsed == null || parsed < 1) {
      return; // Menolak input tidak valid
    }

    widget.onQuantityChanged(
      parsed.clamp(1, widget.maxQuantity), // Membatasi jumlah
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product; // Mengambil data produk

    // Container untuk item keranjang
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Jarak bawah
      padding: const EdgeInsets.all(10), // Jarak dalam

      // Mengatur tampilan Container
      decoration: BoxDecoration(
        color: Colors.white, // Warna background
        borderRadius: BorderRadius.circular(12), // Sudut membulat
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

      // Row menyusun isi secara horizontal
      child: Row(
        children: [

          // Menampilkan gambar produk
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Sudut gambar
            child: SizedBox(
              width: 80, // Lebar gambar
              height: 80, // Tinggi gambar
              child: ProductImage(
                imagePath: product.imagePath, // Path gambar
                icon: product.icon, // Icon produk
                iconSize: 30, // Ukuran icon
              ),
            ),
          ),

          const SizedBox(width: 12), // Jarak gambar

          // Menampilkan informasi produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
              children: [

                // Menampilkan nama produk
                Text(
                  product.name, // Nama produk
                  maxLines: 1, // Maksimal satu baris
                  overflow: TextOverflow.ellipsis, // Teks terpotong
                  style: const TextStyle(
                    fontSize: 14, // Ukuran teks
                    fontWeight: FontWeight.bold, // Teks tebal
                    color: Color(0xFF0F2A1D), // Warna teks
                  ),
                ),

                const SizedBox(height: 2), // Jarak teks

                // Menampilkan deskripsi produk
                Text(
                  product.description, // Deskripsi produk
                  maxLines: 1, // Maksimal satu baris
                  overflow: TextOverflow.ellipsis, // Teks terpotong
                  style: const TextStyle(
                    fontSize: 11, // Ukuran teks
                    color: Color(0xFF6B9071), // Warna teks
                  ),
                ),

                const SizedBox(height: 6), // Jarak deskripsi

                // Menampilkan harga produk
                Text(
                  formatRupiah(product.price), // Format harga
                  style: const TextStyle(
                    fontSize: 14, // Ukuran teks
                    fontWeight: FontWeight.bold, // Teks tebal
                    color: Color(0xFF375534), // Warna teks
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 4), // Jarak informasi

          // Tombol menghapus produk
          IconButton(
            icon: const Icon(
              Icons.delete_outline, // Icon hapus
              color: Color(0xFF6B9071), // Warna icon
              size: 20, // Ukuran icon
            ),
            onPressed: widget.onRemove, // Menjalankan fungsi hapus
          ),

          // Input jumlah produk
          SizedBox(
            width: 56, // Lebar input
            child: TextField(
              controller: quantityController, // Controller jumlah
              keyboardType: TextInputType.number, // Keyboard angka
              textAlign: TextAlign.center, // Posisi teks tengah

              // Membatasi input
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Hanya angka
                LengthLimitingTextInputFormatter(3), // Maksimal 3 digit
              ],

              onChanged: _updateQuantity, // Memvalidasi input

              // Mengatur tampilan input
              decoration: InputDecoration(
                isDense: true, // Membuat input lebih kecil
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10, // Jarak vertikal
                ),

                // Border input
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Sudut border
                  borderSide: const BorderSide(
                    color: Color(0xFFAEC3B0), // Warna border
                  ),
                ),

                // Border saat input aktif
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Sudut border
                  borderSide: const BorderSide(
                    color: Color(0xFFAEC3B0), // Warna border
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}