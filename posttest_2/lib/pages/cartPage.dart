import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/productImage.dart';

// Data satu item di keranjang
class CartItem {
  final String name;
  final String description;
  final int price; // harga disimpan angka agar bisa dihitung
  final IconData icon;
  final String? imagePath;
  final TextEditingController controller; // controller untuk TextField jumlah

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    this.icon = Icons.local_florist,
    this.imagePath,
    int quantity = 1,
  }) : controller = TextEditingController(text: '$quantity');

  // jumlah dibaca dari TextField (kosong dianggap 0)
  int get quantity => int.tryParse(controller.text) ?? 0;
}

// Mengubah angka 85000 menjadi 'Rp85.000'
String formatRupiah(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return 'Rp$buffer';
}

class CartPage extends StatefulWidget {
  // true jika halaman dibuka lewat Navigator.push (perlu tombol kembali)
  final bool showBackButton;

  const CartPage({super.key, this.showBackButton = false});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _query = ''; // kata kunci pencarian

  final List<CartItem> _items = [
    CartItem(
      name: 'Monstera Deliciosa',
      description: 'Tanaman indoor daun besar',
      price: 85000,
      icon: Icons.eco,
      imagePath: 'assets/monstera.jpg',
    ),
    CartItem(
      name: 'Lidah Mertua',
      description: 'Tahan cahaya rendah',
      price: 45000,
      icon: Icons.grass,
      imagePath: 'assets/lidah_mertua.jpg',
      quantity: 2,
    ),
    CartItem(
      name: 'Kaktus Mini',
      description: 'Cocok untuk meja kerja',
      price: 25000,
      icon: Icons.park,
      imagePath: 'assets/kaktus.jpg',
    ),
    CartItem(
      name: 'Sirih Gading',
      description: 'Tanaman merambat gantung',
      price: 35000,
      icon: Icons.local_florist,
      imagePath: 'assets/sirih_gading.jpg',
    ),
    CartItem(
      name: 'Aglonema',
      description: 'Corak daun merah muda',
      price: 65000,
      icon: Icons.spa,
      imagePath: 'assets/aglonema.jpg',
    ),
  ];

  @override
  void dispose() {
    for (final item in _items) {
      item.controller.dispose();
    }
    super.dispose();
  }

  // total harga seluruh item = harga x jumlah
  int get _total =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  @override
  Widget build(BuildContext context) {
    // daftar item yang sesuai dengan pencarian
    final filtered = _items
        .where((i) => i.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE3EED4),

      appBar: AppBar(
        backgroundColor: const Color(0xFFE3EED4),
        elevation: 0,
        automaticallyImplyLeading: false,
        // tombol kembali hanya tampil jika halaman dibuka lewat Navigator.push
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2A1D)),
                onPressed: () => Navigator.pop(context), // Navigator.pop untuk kembali ke halaman sebelumnya
              )
            : null,
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Color(0xFF0F2A1D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      // Stack: daftar item di lapisan bawah, bar total di lapisan atas
      body: Stack(
        children: [
          // Lapisan bawah: search bar + daftar item
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: TextField(
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Cari di keranjang...',
                    hintStyle: const TextStyle(color: Color(0xFF6B9071)),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.search, size: 24, color: Color(0xFF6B9071)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
                      vertical: 16,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: filtered.isEmpty
                    ? const Center(
                        child: Text(
                          'Produk tidak ditemukan',
                          style: TextStyle(color: Color(0xFF6B9071)),
                        ),
                      )
                    : ListView.builder(
                        // padding bawah agar item terakhir tidak tertutup bar total
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) =>
                            _buildCartItem(filtered[index]),
                      ),
              ),
            ],
          ),

          // Lapisan atas: bar total menempel di bawah layar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                // BoxShadow: bayangan ke arah atas (offset y negatif)
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 12, color: Color(0xFF6B9071)),
                      ),
                      Text(
                        formatRupiah(_total),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F2A1D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Checkout ${formatRupiah(_total)}'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart, size: 18),
                      label: const Text('Checkout'),
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
          ),
        ],
      ),
    );
  }

  // Membuat satu kartu item keranjang
  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFAEC3B0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gambar produk (Image.asset, ada fallback icon)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 80,
              height: 80,
              child: ProductImage(
                imagePath: item.imagePath,
                icon: item.icon,
                iconSize: 30,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Nama, deskripsi, harga
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2A1D),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF6B9071)),
                ),
                const SizedBox(height: 6),
                Text(
                  formatRupiah(item.price),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF375534),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // TextField jumlah produk: hanya angka
          SizedBox(
            width: 56,
            child: TextField(
              controller: item.controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              // setiap jumlah berubah, total ikut dihitung ulang
              onChanged: (_) => setState(() {}),
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
        ],
      ),
    );
  }
}