import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/providers/api_providers.dart';

import '../../providers/auth_providers.dart';
import '../../providers/ui_providers.dart';
import 'package:pinterest_clone/widgets/navigation_bar.dart'; // Import NavBar

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authServicesProvider);
    final unsplashPhotosAsyncValue = ref.watch(homePagePhotosProvider);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              authProvider.signUserOut(context);
            },
            child: const Icon(Icons.exit_to_app)),
        title: Text('Current user: ' + user.email!),
        toolbarHeight: 100,
      ),
      body: unsplashPhotosAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (photos) {
          return MasonryGridView.builder(
              itemCount: photos.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) {
                final photo = photos[index];
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
              });
        },
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
