import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/screens/sign-up/location_page.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Interests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select up to 5 topics you are interested in:',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: topics.length,
                itemBuilder: (BuildContext context, int index) {
                  String topic = topics[index];
                  bool isSelected = userState.selectedTopics.contains(topic);
                  return InkWell(
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
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Center(
                        child: Text(
                          topic,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationPage(),
                    ),
                  );
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}