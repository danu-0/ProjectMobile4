import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:tester/theme/theme.dart';

import '../controller/controller.dart';

class OrderDialog extends StatelessWidget {
  final String nama;
  final int harga;
  final String desk;
  final int produkId;
  final String kategori;

  const OrderDialog({
    Key? key,
    required this.nama,
    required this.harga,
    required this.desk,
    required this.produkId,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _quantityController = TextEditingController();

    return AlertDialog(
      backgroundColor: primary,
      title: Text(
        '$nama $kategori',
        style: TextStyle(fontWeight: semiBold, color: white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price: Rp $harga',
            style: TextStyle(color: price),
          ),
          Text(
            'Description: \n$desk',
            style: TextStyle(color: white),
          ),
          TextField(
              style: TextStyle(color: white),
              cursorColor: whiteT,
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah',
                labelStyle: TextStyle(color: white),
              )),
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
            'Add to Order',
            style: TextStyle(color: primary),
          ),
        ),
      ],
    );
  }

  Future<void> _createOrder(BuildContext context, int quantity) async {
    final UserController userController = Get.find();

    final userId = userController.userData['id'];
    final url = Uri.parse('http://10.0.2.2:3000/pesanan');
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
