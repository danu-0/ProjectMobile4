class Produk {
  final int id;
  final String nama;
  final String gambar;
  final int harga;
  final int stok;
  final String desk;

  Produk(
      {required this.id,
      required this.nama,
      required this.gambar,
      required this.harga,
      required this.stok,
      required this.desk});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      nama: json['nama'],
      gambar: json['gambar'],
      harga: json['harga'],
      stok: json['stok'],
      desk: json['desk'],
    );
  }
}
