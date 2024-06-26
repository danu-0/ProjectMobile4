class Produk {
  final int id;
  final String nama;
  final String gambar;
  final int harga;
  final int stok;
  final String desk;
  final String kategori;

  Produk({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.harga,
    required this.stok,
    required this.desk,
    required this.kategori,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      nama: json['nama'],
      gambar: json['gambar'],
      harga: json['harga'],
      stok: json['stok'],
      desk: json['desk'],
      kategori: json['kategori'],
    );
  }
}
