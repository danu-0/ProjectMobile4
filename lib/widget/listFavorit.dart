import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/theme/theme.dart';

class ListFavorite extends StatelessWidget {
  final String nama;
  final String gambar;
  final String total;
  final String nomer;

  const ListFavorite({
    Key? key,
    required this.nama,
    required this.gambar,
    required this.total,
    required this.nomer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 154,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: white,
          border: Border.all(color: secondary, width: 2)),
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
            child: Text(
              "# ${nomer}",
              style: TextStyle(
                  color: selected, fontSize: 20, fontWeight: semiBold),
            ),
          )
        ],
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
  final String total;
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
