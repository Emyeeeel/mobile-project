import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/providers/api_providers.dart';
import '../../providers/user_providers.dart';

final List<String> topics = [
  'Technology',
  'Art',
  'Travel',
  'Food',
  'Music',
  'Fitness',
  'Fashion',
  'Photography',
  'Books',
  'Movies',
  'Gaming',
  'DIY',
];

class InterestedInPage extends ConsumerWidget {
  const InterestedInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.watch(userProvider.notifier);
    final userState = ref.watch(userProvider);
    final topicPhotos = ref.watch(topicPhotosProvider(topics));

    return Column(
      children: [
        const Text(
          'What are you interested in?',
        ),
        const Text(
          'Select up to 5 topics you are interested in:',
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height - 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: topicPhotos.when(
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
                  String topic = topics[index];
                  bool isSelected = userState.selectedTopics.contains(topic);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        userNotifier.removeTopic(topic);
                      } else {
                        userNotifier.addTopic(topic);
                      }
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(color: isSelected ? Colors.red : Colors.grey.shade300, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            photo.photoUrl,
                            fit: BoxFit.cover,
                          ),
                          Center(
                            child: Text(
                              topic,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                            ),
                          ),
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
