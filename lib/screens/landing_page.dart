import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/photo_model.dart';
import '../providers/api_providers.dart';


class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UnsplashPhoto>> photoProvider = ref.watch(landingPagePhotosProvider);
    return Scaffold(
      body: photoProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (List<UnsplashPhoto> photos) {
          return MasonryGridView.builder(
            itemCount: photos.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
            itemBuilder: (BuildContext context, int index) {
              final UnsplashPhoto photo = photos[index];
              return Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          photo.photoUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}