import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/providers.dart';

import '../../services/services.dart';

class InboxPage extends StatelessWidget {
  InboxPage({super.key});

  bool isUpdatesSelected = false;
  bool isMessagesSelected = true;

  @override
  Widget build(BuildContext context) {
    return Center(  
      child: Column(
        children: [
          const SizedBox(height: 50,),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: (){
                  isUpdatesSelected = true;
                  isMessagesSelected = false;
                },
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isUpdatesSelected ? const Color(0xFF797979) : Colors.transparent
                  ),
                  child: Center(
                    child: Text(
                      'Updates',
                      style: TextStyle(
                        color: isUpdatesSelected ? const Color(0xFFEFEFEF) : Colors.black
                      ),
                    ),
                  ),
                )
              ),
              const SizedBox(width: 30,),
              GestureDetector(
                onTap: (){
                  isMessagesSelected = true;
                  isUpdatesSelected = false;
                },
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isMessagesSelected ? const Color(0xFF797979) : Colors.transparent
                  ),
                  child: Center(
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        color: isMessagesSelected ? const Color(0xFFEFEFEF) : Colors.black
                      ),
                    ),
                  ),
                ) 
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 50,),
          isMessagesSelected ? MessagesContainer() : Center(child: Text('Updates'),)
        ],
      )
    );
  }
}

class MessagesContainer extends StatelessWidget {
  const MessagesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            children: [
              const SizedBox(width: 30,),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xFFE70125)
                ),
                child: SizedBox(child: Center(child: Image.asset('lib/assets/Compose.png', width: 25, height: 25,))),
              ),
              const SizedBox(width: 15,),
              const Center(
                child: Text('New Messages'),
              ),
            ],
          ), 
          const SizedBox(height: 20,),
          const Row(
            children: [
              SizedBox(width: 30,),
              Text('Messages'),
            ],
          ),
          const SizedBox(height: 50,),
          const Row(
            children: [
              SizedBox(width: 30,),
              Text('Contacts'),
            ],
          ),
          ContactsList(),
      ],
    );
  }
}

class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(userProfileNotifierProvider);
    return Container(
      width: MediaQuery.of(context).size.width-50,
      height: MediaQuery.of(context).size.height - 360,
      decoration: BoxDecoration(
        border: Border.all(width: 2)
      ),
      child: ListView.builder(
        itemCount: userProfile.contacts.length,
        itemBuilder: (context, index) {
          final contactUser = ref.read(contactListProvider);
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            contactUser.userProfile[index].profilePhotoUrl,
                            fit: BoxFit.cover, 
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
               Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(contactUser.userInfo[index].name),
                    Text('Say Hello'),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          );
        }
      ),
    );
  }
}



// Define a StateNotifier to manage the selection state
final inboxSelectionControllerProvider = StateNotifierProvider<InboxSelectionController, String>((ref) => InboxSelectionController());

class InboxSelectionController extends StateNotifier<String> {
  InboxSelectionController() : super('messages'); // Default to 'messages'

  void selectUpdate() {
    state = 'updates';
  }

  void selectMessage() {
    state = 'messages';
  }
}
