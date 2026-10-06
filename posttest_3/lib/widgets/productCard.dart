import 'package:flutter/material.dart'; // Library Flutter
import 'package:provider/provider.dart'; // State management
import '../models/product.dart'; // Model Product
import '../pages/productDetailPage.dart'; // Halaman detail produk
import '../providers/cartProvider.dart'; // Provider keranjang
import 'productImage.dart'; // Widget gambar produk

// Widget kartu produk horizontal
class ProductCardHorizontal extends StatelessWidget {
  final Product product; // Data produk

  // Constructor ProductCardHorizontal
  const ProductCardHorizontal({
    super.key, // Key widget
    required this.product, // Produk wajib diisi
  });

  @override
  Widget build(BuildContext context) {
    // Membuat seluruh kartu dapat ditekan
    return GestureDetector(
      // Membuka halaman detail produk
      onTap: () {
        Navigator.push(
          context, // Context halaman saat ini
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product, // Mengirim data produk
            ),
          ),
        );
      },

      // Container untuk kartu produk
      child: Container(
        padding: const EdgeInsets.all(12), // Jarak isi kartu

        // Mengatur tampilan kartu
        decoration: BoxDecoration(
          color: Colors.white, // Warna background
          border: Border.all(
            color: const Color(0xFFAEC3B0), // Warna border
          ),
          borderRadius: BorderRadius.circular(12), // Sudut kartu
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300, // Warna bayangan
              blurRadius: 10, // Tingkat blur
              offset: const Offset(0, 3), // Posisi bayangan
            ),
          ],
        ),

        // Menyusun isi kartu secara vertikal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
          children: [
            // Container untuk gambar produk
            Container(
              width: double.infinity, // Lebar penuh
              height: 100, // Tinggi gambar
              clipBehavior: Clip.antiAlias, // Memotong bagian gambar

              // Mengatur tampilan area gambar
              decoration: BoxDecoration(
                color: const Color(0xFFE3EED4), // Warna background
                borderRadius: BorderRadius.circular(8), // Sudut gambar
              ),

              // Stack menumpuk beberapa widget
              child: Stack(
                children: [
                  // Menampilkan gambar produk
                  Positioned.fill(
                    child: ProductImage(
                      imagePath: product.imagePath, // Path gambar
                      icon: product.icon, // Icon produk
                      iconSize: 40, // Ukuran icon
                    ),
                  ),

                  // Menampilkan icon favorit
                  Positioned(
                    top: 6, // Jarak dari atas
                    right: 6, // Jarak dari kanan
                    child: Container(
                      padding: const EdgeInsets.all(4), // Jarak dalam
                      decoration: const BoxDecoration(
                        color: Colors.white, // Warna background
                        shape: BoxShape.circle, // Bentuk lingkaran
                      ),
                      child: const Icon(
                        Icons.favorite_border, // Icon favorit
                        size: 14, // Ukuran icon
                        color: Color(0xFF375534), // Warna icon
                      ),
                    ),
                  ),

                  // Menampilkan label jika stok habis
                  if (product.stock <= 0)
                    Positioned(
                      left: 0, // Mulai dari kiri
                      right: 0, // Sampai kanan
                      bottom: 0, // Berada di bagian bawah
                      child: Container(
                        color: Colors.black54, // Background transparan gelap
                        padding: const EdgeInsets.symmetric(
                          vertical: 4, // Jarak atas dan bawah
                        ),
                        alignment: Alignment.center, // Teks di tengah
                        child: const Text(
                          'Stok Habis', // Teks stok habis
                          style: TextStyle(
                            color: Colors.white, // Warna teks
                            fontSize: 11, // Ukuran teks
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8), // Jarak gambar dan nama

            // Menampilkan nama produk
            Text(
              product.name, // Nama produk
              maxLines: 1, // Maksimal satu baris
              overflow: TextOverflow.ellipsis, // Memotong teks jika panjang
              style: const TextStyle(
                fontSize: 14, // Ukuran teks
                fontWeight: FontWeight.bold, // Teks tebal
                color: Color(0xFF0F2A1D), // Warna teks
              ),
            ),

            const SizedBox(height: 4), // Jarak nama dan rating

            // Menampilkan rating produk
            Row(
              children: [
                const Icon(
                  Icons.star, // Icon bintang
                  size: 14, // Ukuran icon
                  color: Colors.amber, // Warna bintang
                ),
                const SizedBox(width: 4), // Jarak icon dan rating
                Text(
                  '${product.rating}', // Nilai rating
                  style: const TextStyle(
                    fontSize: 12, // Ukuran teks
                    color: Color(0xFF6B9071), // Warna teks
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4), // Jarak rating dan harga
            // Menampilkan harga produk
            Text(
              formatRupiah(product.price), // Format harga Rupiah
              style: const TextStyle(
                fontSize: 15, // Ukuran teks
                fontWeight: FontWeight.bold, // Teks tebal
                color: Color(0xFF375534), // Warna teks
              ),
            ),

            const SizedBox(height: 8), // Jarak harga dan tombol
            // Mengatur ukuran tombol
            SizedBox(
              width: double.infinity, // Lebar tombol penuh
              // Tombol tambah ke keranjang
              child: ElevatedButton(
                // Tombol aktif jika stok masih tersedia
                onPressed: product.stock > 0
                    ? () {
                        // Mengambil CartProvider dan menambahkan produk
                        context.read<CartProvider>().addToCart(product);

                        // Menampilkan pesan setelah produk ditambahkan
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} ditambahkan ke keranjang',
                            ),
                          ),
                        );
                      }
                    : null, // Tombol tidak aktif jika stok habis
                // Mengatur tampilan tombol
                style: ElevatedButton.styleFrom(
                  backgroundColor: product.stock > 0
                      ? const Color(0xFF375534)
                      : Colors.grey, // Warna sesuai stok
                  foregroundColor: Colors.white, // Warna icon
                  minimumSize: const Size(
                    double.infinity,
                    34,
                  ), // Ukuran tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Sudut tombol
                  ),
                ),

                // Icon tombol sesuai kondisi stok
                child: Icon(
                  product.stock > 0
                      ? Icons.shopping_cart
                      : Icons.block, // Icon keranjang atau blok
                  size: 16, // Ukuran icon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Widget kartu produk dalam bentuk grid
class ProductCardGrid extends StatelessWidget {
  final Product product; // Data produk

  // Constructor ProductCardGrid
  const ProductCardGrid({
    super.key, // Key widget
    required this.product, // Produk wajib diisi
  });

  @override
  Widget build(BuildContext context) {
    // Membuat seluruh kartu dapat ditekan
    return GestureDetector(
      // Membuka halaman detail produk
      onTap: () {
        Navigator.push(
          context, // Context halaman saat ini
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product, // Mengirim data produk
            ),
          ),
        );
      },

      // Container untuk kartu produk
      child: Container(
        padding: const EdgeInsets.all(12), // Jarak isi kartu
        // Mengatur tampilan kartu
        decoration: BoxDecoration(
          color: Colors.white, // Warna background
          border: Border.all(
            color: const Color(0xFFAEC3B0), // Warna border
          ),
          borderRadius: BorderRadius.circular(12), // Sudut kartu
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300, // Warna bayangan
              blurRadius: 10, // Tingkat blur
              offset: const Offset(0, 3), // Posisi bayangan
            ),
          ],
        ),

        // Menyusun isi kartu secara vertikal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
          children: [
            // Mengisi ruang yang tersedia untuk gambar
            Expanded(
              child: Container(
                width: double.infinity, // Lebar penuh
                clipBehavior: Clip.antiAlias, // Memotong gambar

                // Mengatur tampilan area gambar
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EED4), // Warna background
                  borderRadius: BorderRadius.circular(8), // Sudut gambar
                ),

                // Stack untuk menumpuk gambar dan icon
                child: Stack(
                  children: [
                    // Menampilkan gambar produk
                    Positioned.fill(
                      child: ProductImage(
                        imagePath: product.imagePath, // Path gambar
                        icon: product.icon, // Icon produk
                        iconSize: 36, // Ukuran icon
                      ),
                    ),

                    // Menampilkan icon favorit
                    Positioned(
                      top: 6, // Jarak dari atas
                      right: 6, // Jarak dari kanan
                      child: Container(
                        padding: const EdgeInsets.all(4), // Jarak dalam
                        decoration: const BoxDecoration(
                          color: Colors.white, // Warna background
                          shape: BoxShape.circle, // Bentuk lingkaran
                        ),
                        child: const Icon(
                          Icons.favorite_border, // Icon favorit
                          size: 14, // Ukuran icon
                          color: Color(0xFF375534), // Warna icon
                        ),
                      ),
                    ),

                    // Menampilkan label jika stok habis
                    if (product.stock <= 0)
                      Positioned(
                        left: 0, // Mulai dari kiri
                        right: 0, // Sampai kanan
                        bottom: 0, // Berada di bagian bawah
                        child: Container(
                          color: Colors.black54, // Background gelap
                          padding: const EdgeInsets.symmetric(
                            vertical: 4, // Jarak atas dan bawah
                          ),
                          alignment: Alignment.center, // Teks di tengah
                          child: const Text(
                            'Stok Habis', // Teks stok habis
                            style: TextStyle(
                              color: Colors.white, // Warna teks
                              fontSize: 10, // Ukuran teks
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8), // Jarak gambar dan nama

            // Menampilkan nama produk
            Text(
              product.name, // Nama produk
              maxLines: 1, // Maksimal satu baris
              overflow: TextOverflow.ellipsis, // Memotong teks jika panjang
              style: const TextStyle(
                fontSize: 13, // Ukuran teks
                fontWeight: FontWeight.bold, // Teks tebal
                color: Color(0xFF0F2A1D), // Warna teks
              ),
            ),

            const SizedBox(height: 4), // Jarak nama dan rating
            // Menampilkan rating produk
            Row(
              children: [
                const Icon(
                  Icons.star, // Icon bintang
                  size: 13, // Ukuran icon
                  color: Colors.amber, // Warna bintang
                ),
                const SizedBox(width: 4), // Jarak icon dan rating
                Text(
                  '${product.rating}', // Nilai rating
                  style: const TextStyle(
                    fontSize: 11, // Ukuran teks
                    color: Color(0xFF6B9071), // Warna teks
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4), // Jarak rating dan harga
            // Menampilkan harga produk
            Text(
              formatRupiah(product.price), // Format harga Rupiah
              style: const TextStyle(
                fontSize: 13, // Ukuran teks
                fontWeight: FontWeight.bold, // Teks tebal
                color: Color(0xFF375534), // Warna teks
              ),
            ),

            const SizedBox(height: 8), // Jarak harga dan tombol
            // Mengatur ukuran tombol
            SizedBox(
              width: double.infinity, // Lebar tombol penuh

              // Tombol tambah ke keranjang
              child: ElevatedButton(
                // Tombol aktif jika stok tersedia
                onPressed: product.stock > 0
                    ? () {
                        // Menambahkan produk ke keranjang
                        context.read<CartProvider>().addToCart(product);

                        // Menampilkan pesan
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} ditambahkan ke keranjang',
                            ),
                          ),
                        );
                      }
                    : null, // Tombol tidak aktif jika stok habis

                // Mengatur tampilan tombol
                style: ElevatedButton.styleFrom(
                  backgroundColor: product.stock > 0
                      ? const Color(0xFF375534)
                      : Colors.grey, // Warna sesuai stok
                  foregroundColor: Colors.white, // Warna icon
                  minimumSize: const Size(
                    double.infinity,
                    32,
                  ), // Ukuran tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Sudut tombol
                  ),
                ),

                // Icon tombol sesuai stok
                child: Icon(
                  product.stock > 0
                      ? Icons.shopping_cart
                      : Icons.block, // Icon keranjang atau blok
                  size: 15, // Ukuran icon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}