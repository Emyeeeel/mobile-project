import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BoardServices{
  Future<void> createBoard(BuildContext context, String boardName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No user logged in');
      return;
    }

    final userId = user.uid;

    try {
      // Save pin metadata to Firestore
      await FirebaseFirestore.instance.collection('boards').add({
        'name': boardName,
        'user_id': userId,
        'created_at': FieldValue.serverTimestamp(),
      });

      print('Board created');
    } catch (e) {
      print('Failed to create board: $e');
    }
  }
  
  Future<void> deleteBoard(BuildContext context, String boardName) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('No user logged in');
      return;
    }

    final userId = user.uid;

    try {
      final boardSnapshot = await FirebaseFirestore.instance
          .collection('boards')
          .where('name', isEqualTo: boardName)
          .where('user_id', isEqualTo: userId)
          .get();

      if (boardSnapshot.docs.isEmpty) {
        print('No board found');
        return;
      }

      final boardId = boardSnapshot.docs.first.id;
      await FirebaseFirestore.instance.collection('boards').doc(boardId).delete();

      print('Board deleted successfully');
    } catch (e) {
      print('Failed to delete board: $e');
    }
  }
}
