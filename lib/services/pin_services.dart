import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinterest_clone/models/pins_model.dart';
import 'package:http/http.dart' as http;

class CreatePin {
  Future<void> pickFile(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null || result.files.isEmpty) {
        // User canceled the picker
        return;
      }

      PlatformFile pickedFile = result.files.first;
      ref.read(pinProvider.notifier).setImage(pickedFile);
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> saveFile(BuildContext context, WidgetRef ref) async {
    final user = FirebaseAuth.instance.currentUser;
    final pins = ref.read(pinProvider);
    if (user == null) {
      print('No user logged in');
      return;
    }

    final userId = user.uid;
    final boardSnapshot = await FirebaseFirestore.instance
        .collection('boards')
        .where('name', isEqualTo: pins.board)
        .where('user_id', isEqualTo: userId)
        .get();

    if (boardSnapshot.docs.isEmpty) {
      print('No board found');
      return;
    }

    final boardId = boardSnapshot.docs.first.id;

    if (pins.image == null) {
      print('File path is null');
      return;
    }

    final file = File(pins.image!.path!); // Assuming the path will not be null
    final storageRef = FirebaseStorage.instance.ref().child('pins/${pins.image!.name}');

    try {
      final uploadTask = await storageRef.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('pins').add({
        'image': downloadUrl,
        'title': pins.title,
        'description': pins.description,
        'board_id': boardId,
        'user_id': userId,
        'created_at': FieldValue.serverTimestamp(),
      });

      print('File uploaded and metadata saved successfully');
    } catch (e) {
      print('Failed to upload file and save metadata: $e');
    }
  }
}

class RemovePin {
  Future<void> removePinFromBoard(BuildContext context, WidgetRef ref, String pinId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('No user logged in');
      return;
    }

    try {
      final pinDoc = await FirebaseFirestore.instance.collection('pins').doc(pinId).get();

      if (!pinDoc.exists) {
        print('Pin not found');
        return;
      }

      await FirebaseFirestore.instance.collection('pins').doc(pinId).delete();

      print('Pin removed successfully');
    } catch (e) {
      print('Failed to remove pin: $e');
    }
  }
}

class SavePin {
  Future<void> saveImageToFirebase(BuildContext context, WidgetRef ref, String imageUrl) async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/temp_image.jpg');
        await file.writeAsBytes(bytes);

        final storageRef = FirebaseStorage.instance.ref().child('pins/${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = await storageRef.putFile(file);
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('pins').add({
          'image': downloadUrl,
          'user_id': user.uid,
          'created_at': FieldValue.serverTimestamp(),
        });

        print('Image saved successfully');
      } else {
        print('Failed to load image');
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }
}