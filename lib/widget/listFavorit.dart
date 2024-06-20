import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:Medaran/theme/theme.dart';
import 'package:Medaran/widget/buton.dart';

class PesananCard extends StatefulWidget {
  final int id;
  final String produkName;
  final int harga;
  final int qtt;
  final String desk;
  final String kategori;
  final String createdAt;
  final VoidCallback onPressed;
  final VoidCallback onpressedEdit;
  final Function(bool) onSelect;

  const PesananCard({
    Key? key,
    required this.id,
    required this.produkName,
    required this.harga,
    required this.qtt,
    required this.desk,
    required this.kategori,
    required this.createdAt,
    required this.onPressed,
    required this.onpressedEdit,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<PesananCard> createState() => _PesananCardState();
}

class _PesananCardState extends State<PesananCard> {
  String formatHarga(int harga) {
    final hargaFormat = NumberFormat("#,##0", "id_ID");
    return hargaFormat.format(harga);
  }

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('d MMM').format(DateTime.parse(widget.createdAt));
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onSelect(isSelected);
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: secondary, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'ID: ${widget.id},',
                      style: TextStyle(
                        color: primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(5),
                    Text(
                      'Kategori: ${widget.kategori}',
                      style: TextStyle(
                        color: primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: isSelected ? primary : secondarytext),
                    color: isSelected ? primary : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
              ],
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.produkName}',
                  style:
                      TextStyle(color: primary, fontSize: 18, fontWeight: bold),
                ),
                Text(
                  'Rp. ${formatHarga(widget.harga)}',
                  style: TextStyle(
                      color: selected, fontSize: 18, fontWeight: semiBold),
                ),
              ],
            ),
            Gap(4),
            SizedBox(height: 4),
            Text(
              'Deskripsi:\n${widget.desk}',
              style: TextStyle(
                color: primary,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah: ${widget.qtt}',
                  style: TextStyle(
                    color: primary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Tanggal: $formattedDate',
                  style: TextStyle(
                    color: primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  child: TextButton(
                      onPressed: widget.onpressedEdit,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            color: primary, fontWeight: semiBold, fontSize: 16),
                      )),
                ),
                Container(
                    width: 120,
                    height: 50,
                    child: buton(onPressed: widget.onPressed, text: 'Hapus')),
                Gap(8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListKeranjang extends StatefulWidget {
  final String nama;
  final String gambar;
  final String total;
  final bool isSelected;
  final Function(bool isSelected) onItemSelected;

  const ListKeranjang({
    Key? key,
    required this.nama,
    required this.gambar,
    required this.total,
    required this.isSelected,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<ListKeranjang> createState() => _ListKeranjangState();
}

class _ListKeranjangState extends State<ListKeranjang> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(5),
                Image(
                  image: AssetImage(
                    widget.gambar,
                  ),
                  height: 82,
                  width: 82,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nama,
                          style: TextStyle(
                              color: primary,
                              fontSize: 20,
                              fontWeight: semiBold)),
                      Text(' RP${widget.total}',
                          style: TextStyle(
                              color: secondarytext,
                              fontSize: 12,
                              fontWeight: regular)),
                      // ItemCounter(
                      //   onCountChanged: (count) {
                      //     setState(() {
                      //       _itemCount = count;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: widget.isSelected,
              activeColor: primary,
              shape: CircleBorder(),
              onChanged: (newValue) {
                widget.onItemSelected(newValue!);
              },
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete))
          ],
        )
      ],
    );
  }
}

class ItemCounter extends StatefulWidget {
  final Function(int count) onCountChanged;

  const ItemCounter({Key? key, required this.onCountChanged}) : super(key: key);
  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int _count = 1;

  void _increment() {
    setState(() {
      _count++;
      widget.onCountChanged(_count);
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 1) {
        _count--;
        widget.onCountChanged(_count);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            color: primary,
            size: 17,
          ),
          onPressed: _decrement,
        ),
        Text(
          '$_count',
          style: TextStyle(fontSize: 18, fontWeight: semiBold, color: primary),
        ),
        IconButton(
          icon: Icon(
            Icons.add_box,
            color: primary,
            size: 17,
          ),
          onPressed: _increment,
        ),
      ],
    );
  }
}

class ListB extends StatelessWidget {
  final String nama;
  final String gambar;
  final int total;
  final String itemcounter;

  const ListB(
      {Key? key,
      required this.nama,
      required this.gambar,
      required this.total,
      required this.itemcounter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 154,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: white,
          border: Border.all(color: secondary, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage(
                          gambar,
                        ),
                        height: 82,
                        width: 82,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nama,
                            style: TextStyle(
                                color: primary,
                                fontSize: 20,
                                fontWeight: semiBold)),
                        Text('pemesanan ${total}',
                            style: TextStyle(
                                color: secondarytext,
                                fontSize: 12,
                                fontWeight: regular))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(itemcounter))
        ],
      ),
    );
  }
}
