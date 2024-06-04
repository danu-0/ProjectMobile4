class Produk {
  final int id;
  final String nama;
  final int harga;
  final int stok;
  final String desk;
  final String kategori;
  final String? gambar;

  Produk({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
    
    required this.desk,
    required this.kategori,
    this.gambar,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      stok: json['stok'],
      desk: json['desk'],
      kategori: json['kategori'],
      gambar: json['gambar'],
    );
  }
}
