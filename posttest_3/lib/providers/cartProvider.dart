import 'package:flutter/material.dart'; // Import package UI utama Flutter
import '../models/product.dart'; // Import model data produk

// State Management keranjang & stok menggunakan Provider (ChangeNotifier)
class CartProvider extends ChangeNotifier {
  // Daftar data produk beserta detail dan stok awal
  final List<Product> products = [
    Product(
      id: 'p1', // ID unik produk
      name: 'Monstera Deliciosa', // Nama produk
      price: 85000, // Harga produk
      rating: 4.8, // Penilaian produk
      icon: Icons.eco, // Ikon indikator produk
      imagePath: 'assets/monstera.jpg', // Path gambar produk
      description:
          'Tanaman hias indoor dengan daun besar berlubang yang khas. Mudah dirawat dan cocok diletakkan di ruang tamu.', // Deskripsi produk
      stock: 8, // Jumlah stok tersedia
    ),
    Product(
      id: 'p2', // ID unik produk
      name: 'Lidah Mertua', // Nama produk
      price: 45000, // Harga produk
      rating: 4.6, // Penilaian produk
      icon: Icons.grass, // Ikon indikator produk
      imagePath: 'assets/lidah_mertua.jpg', // Path gambar produk
      description:
          'Tanaman tahan banting yang bisa hidup di cahaya rendah dan membantu menyaring udara dalam ruangan.', // Deskripsi produk
      stock: 12, // Jumlah stok tersedia
    ),
    Product(
      id: 'p3', // ID unik produk
      name: 'Kaktus Mini', // Nama produk
      price: 25000, // Harga produk
      rating: 4.5, // Penilaian produk
      icon: Icons.park, // Ikon indikator produk
      imagePath: 'assets/kaktus.jpg', // Path gambar produk
      description:
          'Kaktus berukuran kecil, cocok untuk dekorasi meja kerja. Cukup disiram seminggu sekali.', // Deskripsi produk
      stock: 0, // Stok habis untuk pengujian UI
    ),
    Product(
      id: 'p4', // ID unik produk
      name: 'Sirih Gading', // Nama produk
      price: 35000, // Harga produk
      rating: 4.7, // Penilaian produk
      icon: Icons.local_florist, // Ikon indikator produk
      imagePath: 'assets/sirih_gading.jpg', // Path gambar produk
      description:
          'Tanaman merambat dengan daun berwarna hijau-kuning yang indah, cocok untuk pot gantung.', // Deskripsi produk
      stock: 15, // Jumlah stok tersedia
    ),
    Product(
      id: 'p5', // ID unik produk
      name: 'Palem Kuning', // Nama produk
      price: 120000, // Harga produk
      rating: 4.4, // Penilaian produk
      icon: Icons.forest, // Ikon indikator produk
      imagePath: 'assets/palem_kuning.jpg', // Path gambar produk
      description:
          'Palem cantik dengan tampilan tropis yang memberi kesan segar pada teras maupun ruangan.', // Deskripsi produk
      stock: 5, // Jumlah stok tersedia
    ),
    Product(
      id: 'p6', // ID unik produk
      name: 'Aglonema', // Nama produk
      price: 65000, // Harga produk
      rating: 4.9, // Penilaian produk
      icon: Icons.spa, // Ikon indikator produk
      imagePath: 'assets/aglonema.jpg', // Path gambar produk
      description:
          'Tanaman dengan corak daun merah muda yang menarik dan tahan di ruangan minim cahaya.', // Deskripsi produk
      stock: 9, // Jumlah stok tersedia
    ),
  ];

  // Map untuk menyimpan jumlah item di keranjang berdasarkan ID produk
  final Map<String, int> cartQuantities = {};

  // Getter menghitung total harga seluruh isi keranjang
  int get grandTotal => products.fold(0, (total, product) {
        return total + product.price * (cartQuantities[product.id] ?? 0); // Total = total + (harga * jumlah)
      });

  // Getter menghitung total jumlah seluruh item di keranjang
  int get totalItemCount =>
      cartQuantities.values.fold(0, (sum, qty) => sum + qty); // Menjumlahkan seluruh kuantitas item

  // Mengembalikan jumlah kuantitas produk tertentu di keranjang
  int quantityOf(Product product) => cartQuantities[product.id] ?? 0;

  // Menambahkan 1 item produk ke keranjang dan mengurangi stok
  void addToCart(Product product) {
    if (product.stock <= 0) return; // Batalkan jika stok habis
    product.stock--; // Kurangi stok produk
    cartQuantities[product.id] = (cartQuantities[product.id] ?? 0) + 1; // Tambah jumlah di keranjang
    notifyListeners(); // Notifikasi perubahan state ke UI
  }

  // Menambahkan beberapa jumlah item ke keranjang sekaligus
  bool addMultiple(Product product, int qty) {
    if (qty <= 0 || qty > product.stock) return false; // Validasi stok
    product.stock -= qty; // Kurangi stok sejumlah qty
    cartQuantities[product.id] = (cartQuantities[product.id] ?? 0) + qty; // Tambah jumlah di keranjang
    notifyListeners(); // Notifikasi perubahan state ke UI
    return true; // Berhasil
  }

  // Mengubah jumlah item keranjang secara manual dari input
  void changeQuantity(Product product, int newQuantity) {
    final current = cartQuantities[product.id] ?? 0; // Kuantitas saat ini
    final diff = newQuantity - current; // Selisih perubahan kuantitas
    if (diff > 0 && diff > product.stock) return; // Batalkan jika melebihi stok
    product.stock -= diff; // Penyesuaian stok berdasarkan selisih
    if (newQuantity <= 0) {
      cartQuantities.remove(product.id); // Hapus dari keranjang jika kuantitas 0
    } else {
      cartQuantities[product.id] = newQuantity; // Update kuantitas baru
    }
    notifyListeners(); // Notifikasi perubahan state ke UI
  }

  // Menghapus produk dari keranjang dan mengembalikan stoknya
  void removeFromCart(Product product) {
    product.stock += cartQuantities[product.id] ?? 0; // Kembalikan stok produk
    cartQuantities.remove(product.id); // Hapus item dari Map keranjang
    notifyListeners(); // Notifikasi perubahan state ke UI
  }

  // Mengosongkan keranjang belanja saat selesai checkout
  void checkout() {
    cartQuantities.clear(); // Kosongkan data keranjang
    notifyListeners(); // Notifikasi perubahan state ke UI
  }
}