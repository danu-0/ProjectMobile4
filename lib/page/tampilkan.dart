import 'package:flutter/material.dart';

class Foto extends StatelessWidget {
  const Foto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/image-produk-medaran.appspot.com/o/UyL2n2aNb0Y9tZFgs1GFhYtEoGj2%2Fuploads%2F1715843768333534-pai%20(1).png?alt=media&token=61083e2a-b312-4ffc-af5a-675668749d6d'))),
      ),
    );
  }
}
