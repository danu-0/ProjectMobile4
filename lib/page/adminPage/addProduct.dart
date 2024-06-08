import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';

import 'package:tester/theme/theme.dart';
import 'package:tester/widget/buton.dart';
import 'package:tester/widget/formUpload.dart';

class UploadProductPage extends StatefulWidget {
  @override
  _UploadProductPageState createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _deskController = TextEditingController();
  File? _imageFile;
  String? _imageUrl;
  final List<String> _categories = ['Makanan', 'Minuman', 'Snack'];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    signInUserAnon();
  }

  Future<void> signInUserAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print('Signed in with UID: ${userCredential.user?.uid}');
    } catch (e) {
      print(e);
    }
  }

  Future<void> selectImageFromGallery() async {
    try {
      List<MediaFile>? singleMedia =
          await GalleryPicker.pickMedia(context: context, singleMedia: true);
      if (singleMedia != null && singleMedia.isNotEmpty) {
        File? file = await singleMedia.first.getFile();
        setState(() {
          _imageFile = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_imageFile == null) return;

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref();
      final filename = _imageFile!.path.split("/").last;
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final uploadRef =
          storageRef.child("$userId/uploads/$timestamp-$filename");
      await uploadRef.putFile(_imageFile!);

      final url = await uploadRef.getDownloadURL();
      setState(() {
        _imageUrl = url;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> createProduct() async {
    if (_imageUrl == null) {
      Get.snackbar(
        'Error',
        'Please upload an image first.',
        backgroundColor: Colors.white.withOpacity(0.8),
        colorText: Colors.black,
      );
      return;
    }

    final url = Uri.parse(
        'https://nest-js-nine.vercel.app/product'); // Sesuaikan dengan endpoint backend Anda
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text);
    final stock = int.tryParse(_stockController.text);
    final deskrispi = _deskController.text;

    if (name.isEmpty ||
        price == null ||
        stock == null ||
        deskrispi.isEmpty ||
        _selectedCategory == null) {
      Get.snackbar(
        'Error',
        'Please fill all fields.',
        backgroundColor: Colors.white.withOpacity(0.8),
        colorText: Colors.black,
      );
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'nama': name,
          'gambar': _imageUrl,
          'harga': price,
          'desk': deskrispi,
          'stok': stock,
          'kategori': _selectedCategory,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Product created successfully',
          backgroundColor: Colors.white.withOpacity(0.8),
          colorText: Colors.black,
        );
      } else {
        final responseData = jsonDecode(response.body);
        final errorMessage =
            responseData['message'] ?? 'Failed to create product';
        Get.snackbar(
          'Error',
          errorMessage,
          backgroundColor: Colors.white.withOpacity(0.8),
          colorText: Colors.black,
        );
      }
    } catch (error) {
      print('Failed to create product: $error');
      Get.snackbar(
        'Error',
        'Failed to create product. Please try again later.',
        backgroundColor: Colors.white.withOpacity(0.8),
        colorText: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
          child: ListView(
            children: [
              GestureDetector(
                onTap: selectImageFromGallery,
                child: DottedBorder(
                    dashPattern: [4.4],
                    strokeWidth: 2,
                    radius: Radius.circular(10),
                    color: secondarytext,
                    child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5)),
                        child: _imageFile == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    IconButton(
                                      onPressed: selectImageFromGallery,
                                      icon: Icon(
                                          Icons.drive_folder_upload_outlined),
                                      iconSize: 36,
                                      color: secondarytext,
                                    ),
                                    Text(
                                      'Select Image',
                                      style: TextStyle(color: secondarytext),
                                    )
                                  ])
                            : Image.file(
                                _imageFile!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ))),
              ),
              Gap(10),
              _imageFile == null
                  ? Center(
                      child: Text(
                        'No image selected.',
                        style: TextStyle(color: secondarytext),
                      ),
                    )
                  : Text(
                      _imageFile!.path.split('/').last,
                      style: TextStyle(color: primary, fontWeight: bold),
                    ),
              Gap(20),
              CustomKeyboard(
                  desk: 'Product Name',
                  keyboardType: TextInputType.text,
                  controller: _nameController),
              Gap(20),
              CustomKeyboard(
                  desk: 'Desk',
                  keyboardType: TextInputType.text,
                  controller: _deskController),
              Gap(20),
              CustomKeyboard(
                  desk: 'Price',
                  keyboardType: TextInputType.number,
                  controller: _priceController),
              Gap(20),
              CustomKeyboard(
                  desk: 'Stock',
                  keyboardType: TextInputType.number,
                  controller: _stockController),
              Gap(30),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items:
                    _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: secondarytext),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Gap(30),
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: buton(
                  onPressed: () async {
                    await uploadImageToFirebase();
                    await createProduct();
                  },
                  text: 'Upload'),
            ))
      ]),
    );
  }
}
