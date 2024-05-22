import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/auth_providers.dart';
import 'package:pinterest_clone/providers/pinterest_user_provider.dart';


import '../../../providers/user_providers.dart';
import 'settings_page.dart';

// ignore: must_be_immutable
class SavedPage extends ConsumerWidget {
  SavedPage({super.key});

  bool isPinsClicked = true;
  bool isBoardsClicked = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(pinterestUserProvider);
    final service = ref.watch(userServicesProvider);
    final auth = ref.watch(authServicesProvider);
    service.getCurrentUserDetails(ref);
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
          user.profilePhotoURL == null ? Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xFF404040)
            ),
            child: Center(
              child: Text(
                user.currentUser!.name!.substring(0, 1),
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
                user.profilePhotoURL!,
                fit: BoxFit.cover, 
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Text('${user.currentUser!.name}', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
          Row(
            children: [
              const Spacer(),
              Center(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SvgPicture.asset( 
                    'lib/assets/logo_svg.svg',
                    width: 20,
                    height: 20,
                    color: Colors.black, 
                  ),
                ),
              ),
              const SizedBox(width: 2.5,),
              Text(
                service.truncateEmail(user.userName!),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Text('${user.followers!.length.toString()} followers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
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
              Text('${user.following!.length.toString()} following', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
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
          Row(
            children: [
              SizedBox(width: 20,),
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
              const Icon(Icons.add),
              SizedBox(width: 20,),
            ],
          ),
          // Center(
          //   child: Text('Current user UID: ${service.currentUser.uid}'),
          // ),
          // Text('Email: ${user.currentUser!.email}'),
          // Text('Name: ${user.currentUser!.name}'),
          // Text('Date of Birth: ${user.currentUser!.dateOfBirth}'),
          // Text('Gender: ${user.currentUser!.gender}'),
          // Text('Location: ${user.currentUser!.location}'),
          // Text('Selected Topics: ${user.currentUser!.selectedTopics}'),
        ],
      ),
    );
  }
}