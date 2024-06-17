import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';

Future<void> signInUserAnon() async {
  try {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    print('object:${userCredential.user?.uid}');
  } catch (e) {
    print(e);
  }
}

Future<File?> getImmageFromGalery(BuildContext context) async {
  try {
    List<MediaFile>? singleMedia =
        await GalleryPicker.pickMedia(context: context, singleMedia: true);
    return singleMedia?.first.getFile();
  } catch (e) {
    print(e);
  }
  return null;
}

Future uploadimage(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final storageRef = FirebaseStorage.instance.ref();
    final filename = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/uploads/$timestamp-$filename");
    await uploadRef.putFile(file);

    final Url = await uploadRef.getDownloadURL();
    print(Url);
    return Url;
  } catch (e) {
    print(e);
  }
  return false;
  // return '';
}
