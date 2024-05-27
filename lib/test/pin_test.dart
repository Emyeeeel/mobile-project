import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/services/pin_services.dart' as pinServices;

import '../models/create_pin_model.dart';
import '../widgets/main_page.dart'; // Adjust the import path as necessary

class TestPage extends ConsumerWidget {
  TestPage({Key? key}) : super(key: key);

  final TextEditingController boardNameController = TextEditingController();
  final TextEditingController pinTitleController = TextEditingController();
  final TextEditingController pinDescriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController pinIdController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createPin = pinServices.CreatePin();
    final removePin = pinServices.RemovePin();
    final savePin = pinServices.SavePin();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150, 
        title:const Text('Create Pin'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: boardNameController,
              decoration: InputDecoration(labelText: 'Board Name'),
            ),
            TextField(
              controller: pinTitleController,
              decoration: InputDecoration(labelText: 'Pin Title'),
            ),
            TextField(
              controller: pinDescriptionController,
              decoration: InputDecoration(labelText: 'Pin Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await createPin.pickFile(context, ref);
              },
              child: Text('Pick File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                ref.read(pinProvider.notifier).setBoard(boardNameController.text.trim());
                ref.read(pinProvider.notifier).setTitle(pinTitleController.text.trim());
                ref.read(pinProvider.notifier).setDescription(pinDescriptionController.text.trim());
                await createPin.saveFile(context, ref);
              },
              child: Text('Save Pin'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: pinIdController,
              decoration: InputDecoration(labelText: 'Pin ID to Remove'),
            ),
            ElevatedButton(
              onPressed: () async {
                await removePin.removePinFromBoard(context, ref, pinIdController.text.trim());
              },
              child: Text('Remove Pin'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            ElevatedButton(
              onPressed: () async {
                await savePin.saveImageToFirebase(context, ref, imageUrlController.text.trim());
              },
              child: Text('Save Image from URL'),
            ),
          ],
        ),
      ),
    );
  }
}