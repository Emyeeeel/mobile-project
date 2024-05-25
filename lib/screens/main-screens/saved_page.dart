import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/auth_providers.dart';
import 'package:pinterest_clone/providers/providers.dart';
import 'package:pinterest_clone/services/services.dart';

import '../../widgets/main_page.dart';

class SavedPage extends ConsumerWidget {
  SavedPage({super.key});

  bool isPinsClicked = true;
  bool isBoardsClicked = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authServicesProvider);
    final user = ref.watch(userModelNotifierProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);
    ref.watch(backendeServicesProvider).getUserModelDataByEmail(FirebaseAuth.instance.currentUser!.email!, ref);
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50,),
          Row(
            children: [
              const Spacer(),
              const Icon(Icons.upload, size: 30,),
              const SizedBox(width: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                },
                child: const Icon(Icons.settings, size: 30,)
              ),
              const SizedBox(width: 20,),
            ],
          ),
          const SizedBox(height: 30,),
          userProfile.profilePhotoUrl == '' ? Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xFF404040)
                      ),
                      child: Center(
                        child: Text(
                          user.name.substring(0, 1),
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600)
                        ),
                      )
                    ) : Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          userProfile.profilePhotoUrl,
                          fit: BoxFit.cover, 
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(user.name, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        const Spacer(),
                        Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black, 
                            ),
                          ),
                        ),
                        const SizedBox(width: 2.5,),
                        Text(
                          userProfile.username,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text('${userProfile.followers.length.toString()} followers', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,5,0),
                          child: Center(
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xFF404040)
                              ),
                            ),
                          ),
                        ),
                        Text('${userProfile.following.length.toString()} following', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                        const Spacer(),
                      ],
                    ),
                    MaterialButton(
                      onPressed: (){
                        
                      },
                      minWidth: 125,
                      height: 55,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: const Color(0xFF404040),
                      child: const Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFA3A3A3)),),
                    ),
          const SizedBox(height: 20,),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: (){
                  isPinsClicked = true;
                  isBoardsClicked = false;
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isPinsClicked ? Colors.black : Colors.transparent, 
                        width: 2.0, 
                      ),
                    ),
                  ),
                  child: const Text(
                    'Pins',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ),
              const SizedBox(width: 40,),
              GestureDetector(
                onTap: (){
                  isBoardsClicked = true;
                  isPinsClicked = false;
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isBoardsClicked ? Colors.black : Colors.transparent, 
                        width: 2.0, 
                      ),
                    ),
                  ),
                  child: const Text(
                    'Boards',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ) 
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20,),
          isPinsClicked ? const PinsPage() : const BoardsPage()
        ],
      ),
    );
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(backendeServicesProvider);
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded)
                  ),
                  const Spacer(),
                  const Text('Your Account'),
                  const Spacer(),
                  const SizedBox(width: 20,),
                ],
              ),
              const SizedBox(height: 50,),
              const Row(children: [SizedBox(width: 20,),Text('Settings')],),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Account management'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Profile visibility'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Home feed tuner'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Claimed accounts'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Social permissions'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Notifications'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Privacy and data'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Reports and violations center'),
              const SizedBox(height: 50,),
              const Row(children: [SizedBox(width: 20,),Text('Log in')],),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Add Account'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Security'),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  GestureDetector(
                    onTap: (){
                      service.signUserOut(context, ref);
                    },
                    child: const Text('Logout')
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20,),
        Text(text),
        const Spacer(),
        GestureDetector(
          onTap: () {
                      
          },
          child: const Icon(
            Icons.arrow_forward_ios_rounded)
          ),
        const SizedBox(width: 20,),
      ],
    );
  }
}


class PinsPage extends StatelessWidget {
  const PinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: Colors.black), 
                ),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      const Icon(Icons.search),
                      const SizedBox(width: 2.5,),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search your saved ideas',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Transform.rotate(
                angle: 90 * 3.1415926535897932 / 180,
                child: const Icon(Icons.compare_arrows_rounded),
              ),
              const SizedBox(width: 20,),
              const Icon(Icons.add),
              const SizedBox(width: 20,),
            ],
          ),
        ],
      ),
    );
  }
}

class BoardsPage extends StatelessWidget {
  const BoardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: Colors.black), 
                ),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      const Icon(Icons.search),
                      const SizedBox(width: 2.5,),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search your saved ideas',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              const Icon(Icons.apps_rounded),
              const SizedBox(width: 20,),
              const Icon(Icons.add),
              const SizedBox(width: 20,),
            ],
          ),
        ],
      ),
    );
  }
}