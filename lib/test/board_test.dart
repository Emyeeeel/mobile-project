import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinterest_clone/services/board_services.dart'; // Adjust the import as necessary

class BoardPage extends ConsumerWidget {
  BoardPage({Key? key}) : super(key: key);

  final TextEditingController boardNameController = TextEditingController();
  final BoardServices boardServices = BoardServices();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Boards'),
        ),
        body: const Center(
          child: Text('No user logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boards'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: boardNameController,
              decoration: const InputDecoration(
                labelText: 'Board Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final boardName = boardNameController.text.trim();
                if (boardName.isNotEmpty) {
                  await boardServices.createBoard(context, boardName);
                } else {
                  print('Board name is empty');
                }
              },
              child: const Text('Create Board'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final boardName = boardNameController.text.trim();
                if (boardName.isNotEmpty) {
                  await boardServices.deleteBoard(context, boardName);
                } else {
                  print('Board name is empty');
                }
              },
              child: const Text('Delete Board'),
            ),
          ],
        ),
      ),
    );
  }
}