import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinterest_clone/services/board_services.dart';

class DisplayPinsPage extends StatelessWidget {
  final String boardName;
  DisplayPinsPage({required this.boardName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pins for Board: $boardName'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: BoardServices().fetchPins(boardName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No pins found for this board'));
          }

          final pins = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: pins.length,
            itemBuilder: (context, index) {
              final pin = pins[index].data() as Map<String, dynamic>;

              // Get the image URL from Firestore
              final imageUrl = pin['image'] ?? '';

              return FutureBuilder<String>(
                future: BoardServices().getImageUrl(imageUrl),
                builder: (context, imageUrlSnapshot) {
                  if (imageUrlSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (imageUrlSnapshot.hasError) {
                    return Center(child: Text('Error loading image: ${imageUrlSnapshot.error}'));
                  }

                  final imageUrl = imageUrlSnapshot.data ?? '';

                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                )
                              : Center(child: Text('No Image')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pin['title'] ?? 'No Title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(pin['description'] ?? 'No Description'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}