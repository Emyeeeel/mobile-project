import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/widgets/landing_widgets.dart';

import '../models/photo_model.dart';
import '../providers/api_providers.dart';


class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UnsplashPhoto>> photoProvider = ref.watch(landingPagePhotosProvider);
    return Scaffold(
      body: Stack(
        children: [
          photoProvider.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            data: (List<UnsplashPhoto> photos) {
              return MasonryGridView.builder(
                itemCount: photos.length,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                itemBuilder: (BuildContext context, int index) {
                  final UnsplashPhoto photo = photos[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
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
          const Positioned(
            bottom: 0,
            child: LandingPageWidget()
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height / 3),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: [Colors.black.withOpacity(0), Colors.white],
                ),
              ),
            ),
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width/2) - 60,
            bottom: (MediaQuery.of(context).size.height / 3) - 50,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/pinterest_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}

