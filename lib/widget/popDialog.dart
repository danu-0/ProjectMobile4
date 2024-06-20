import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:Medaran/theme/theme.dart';

import '../controller/controller.dart';

class OrderDialog extends StatelessWidget {
  final String nama;
  final int harga;
  final String desk;
  final int produkId;
  final String kategori;
  final String gambar;

  const OrderDialog(
      {Key? key,
      required this.nama,
      required this.harga,
      required this.desk,
      required this.produkId,
      required this.kategori,
      required this.gambar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _quantityController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 400,
            width: 350,
          ),
          Positioned(
              top: 20,
              left: 80,
              right: 80,
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                    color: price, borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: gambar,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              )),
          Positioned(
            top: 160,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  nama,
                  style: TextStyle(
                    fontSize: 24,
                    color: primary,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(10),
                Text(
                  desk,
                  style: TextStyle(
                    fontSize: 18,
                    color: primary,
                    fontWeight: regular,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 230,
            left: 20,
            right: 20,
            child: Form(
              child: Column(
                children: [
                  TextField(
                      style: TextStyle(color: primary),
                      cursorColor: primary2,
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Jumlah',
                        labelStyle: TextStyle(color: primary),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () async {
                    final quantity = int.tryParse(_quantityController.text);
                    if (quantity != null && quantity > 0) {
                      await _createOrder(context, quantity);
                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please enter a valid quantity',
                        backgroundColor: Colors.white.withOpacity(0.8),
                        colorText: primary,
                      );
                    }
                  },
                  child: Text(
                    'Pesan',
                    style: TextStyle(color: white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createOrder(BuildContext context, int quantity) async {
    final UserController userController = Get.find();

    final userId = userController.userData['id'];
    final url = Uri.parse('https://nest-js-nine.vercel.app/pesanan');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': userId,
        'produkId': produkId,
        'ProdukName': nama,
        'harga': harga,
        'qtt': quantity,
        'desk': desk,
        'kategori': kategori,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Order created successfully',
        backgroundColor: Colors.white.withOpacity(0.8),
        colorText: Colors.black,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to create order',
        backgroundColor: Colors.white.withOpacity(0.8),
        colorText: Colors.black,
      );
    }
  }
}

class UpdateOrderDialog extends StatefulWidget {
  final int pesananId;
  final String nama;
  final int harga;
  final String desk;
  final int currentQtt;
  final String kategori;

  UpdateOrderDialog({
    Key? key,
    required this.pesananId,
    required this.nama,
    required this.harga,
    required this.desk,
    required this.currentQtt,
    required this.kategori,
  }) : super(key: key);

  @override
  State<UpdateOrderDialog> createState() => _UpdateOrderDialogState();
}

class _UpdateOrderDialogState extends State<UpdateOrderDialog> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _quantityController = TextEditingController();
    _quantityController.text = widget.currentQtt.toString();

    return AlertDialog(
      backgroundColor: primary,
      title: Text(
        '${widget.nama}',
        style: TextStyle(fontWeight: FontWeight.bold, color: white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price: Rp ${widget.harga}',
            style: TextStyle(color: price),
          ),
          Text(
            'Deskripsi: \n${widget.desk}',
            style: TextStyle(color: white),
          ),
          TextField(
            style: TextStyle(color: white),
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Jumlah',
              labelStyle: TextStyle(
                color: white,
              ),
            ),
            cursorColor: whiteT,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final quantity = int.tryParse(_quantityController.text);
            if (quantity != null && quantity > 0) {
              Navigator.of(context).pop(quantity); // Pass the new quantity back
            } else {
              Get.snackbar(
                'Error',
                'Please enter a valid quantity',
                backgroundColor: Colors.white.withOpacity(0.8),
                colorText: Colors.black,
              );
            }
          },
          child: Text(
            'Update Order',
            style: TextStyle(color: primary),
          ),
        ),
      ],
    );
  }
}

class Dialoguu extends StatelessWidget {
  final String alert;
  final String pesan;
  final String btn;
  final VoidCallback onPressed;

  Dialoguu(
      {Key? key,
      required this.alert,
      required this.pesan,
      required this.btn,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primary,
      title: Text(
        alert,
        style: TextStyle(fontWeight: FontWeight.bold, color: white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pesan,
            style: TextStyle(color: price),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: white),
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(
            btn,
            style: TextStyle(color: primary),
          ),
        ),
      ],
    );
  }
}
