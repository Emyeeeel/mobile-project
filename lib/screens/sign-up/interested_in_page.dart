import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  const InterestedInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.watch(userProvider.notifier);
    final userState = ref.watch(userProvider);

    return Column(
      children: [
        Text(
          'What are you interested in?',
        ),
        Text(
          'Select up to 5 topics you are interested in:',
        ),
        SizedBox(height: 15),
      Container(
        width: MediaQuery.of(context).size.width - 40,
        height: MediaQuery.of(context).size.height - 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GridView.builder(
            itemCount: topics.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 10.0, 
              mainAxisSpacing: 10.0, 
            ),
            itemBuilder: (BuildContext context, int index) {
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
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.grey.shade300,
                    border: Border.all(color: isSelected ? Colors.red : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(topic, style: TextStyle(color: isSelected ? Colors.white : Colors.black),),
                ),
              );
            },
          ),
      )
      ],
    );
  }
}

