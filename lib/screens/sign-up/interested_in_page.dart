import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/providers/api_providers.dart';
import 'package:pinterest_clone/providers/providers.dart';
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
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  String topic = topics[index];
                  bool isSelected = ref.watch(userModelNotifierProvider).selectedTopics.contains(topic);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        ref.watch(userModelNotifierProvider.notifier).removeTopic(topic);
                      } else {
                        ref.watch(userModelNotifierProvider.notifier).addTopic(topic);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Container(
                            
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(color: isSelected ? Colors.red : Colors.grey.shade300, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ClipRRect(
                            child: Image.network(
                              photo.photoUrl,
                              fit: BoxFit.cover,
                            ),
                          ),),
                          Positioned(
                            bottom: -15,
                            child: Text(topic,),
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
