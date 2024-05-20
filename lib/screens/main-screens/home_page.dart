import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/providers/api_providers.dart';

import '../../providers/ui_providers.dart';
import '../../widgets/photo_widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unsplashPhotosAsyncValue = ref.watch(homePagePhotosProvider);

    return Column(
      children: [
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 75,
          child: unsplashPhotosAsyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            data: (photos) {
              return MasonryGridView.builder(
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PinImage(photoUrl: photo.photoUrl,)));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                photo.photoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final uiService = ref.watch(uiServiceProvider);
                              uiService.displayDetails(
                                  context, photo.photographerUsername);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: List.generate(
                                        3,
                                        (index) => Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(50),
                                                    color: Colors.black),
                                              ),
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
