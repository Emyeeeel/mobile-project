import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../services/services.dart'; 

class Test extends ConsumerWidget {
  Test({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final List<String> genders = [
    'Female',
    'Male',
    'Specify others'
  ];

  final List<String> interest = [
    'Arts',
    'Music',
    'Movies',
    'Food',
    'Sports'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userModelNotifierProvider.notifier);
    final service = ref.watch(backendeServicesProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController, 
            decoration: const InputDecoration(
              hintText: 'Email', 
              hintStyle: TextStyle(color: Colors.grey), 
            ),
            onChanged: (value) {
              user.setEmail(value);
            },
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey), 
            ),
            obscureText: true, 
            onChanged: (value) {
              user.setPassword(value);
            },
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Name',
              hintStyle: TextStyle(color: Colors.grey), 
            ),
            onChanged: (value) {
              user.setName(value);
            }, 
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.mdy,
              initialDateTime: DateTime.now(), 
              onDateTimeChanged: (DateTime newDateTime) {
                user.setBirthday(newDateTime);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: MaterialButton(
              onPressed: (){
                user.setGender(genders[0]);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minWidth: MediaQuery.of(context).size.width - 180,
              height: 25,
              child: Center(
                child: Text(genders[0]),
                ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: MaterialButton(
              onPressed: (){
                user.setGender(genders[1]);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minWidth: MediaQuery.of(context).size.width - 180,
              height: 25,
              child: Center(
                child: Text(genders[1]),
                ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: MaterialButton(
              onPressed: (){
                user.setGender(genders[2]);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minWidth: MediaQuery.of(context).size.width - 180,
              height: 25,
              child: Center(
                child: Text(genders[2]),
                ),
            ),
          ),
          GestureDetector(
            onTap: (){
              user.setCountryName('Philippines');
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1)
              ),
              child: const Center(
                child: Text('Philippines'),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              user.setSelectedTopics(interest);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1)
              ),
              child: const Center(
                child: Text('Set Topics'),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              showModalBottomSheet(
                context: context, 
                builder: (context) => Column(
                  children: [
                    Text(user.email),
                    Text(user.password),
                    Text(user.name),
                    Text(user.birthday.toString()),
                    Text(user.gender),
                    Text(user.countryName),
                    Text(user.selectedTopics[0]),
                    Text(user.selectedTopics[1]),
                    Text(user.selectedTopics[2]),
                    Text(user.selectedTopics[3]),
                    Text(user.selectedTopics[4]),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
                        service.saveUserToFirestore(ref);
                        service.updateUserUIDAndSave(ref);
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1)
                        ),
                        child: const Center(
                          child: Text('Send Data'),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              );
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1)
              ),
              child: const Center(
                child: Text('Display Data'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class TestUser extends ConsumerWidget {
  const TestUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(userProfileNotifierProvider.notifier);
    final service = ref.watch(backendeServicesProvider);
    final user = ref.watch(userModelNotifierProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(userProfile.userId),
          MaterialButton(
            onPressed: (){
              userProfile.setProfilePhotoUrl('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTp2sgLeB4N7WAzCKQY4A5v1QdAzfR7fOjbaZMohajK_Q&s');
            },
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(50),
            ),
            minWidth: MediaQuery.of(context).size.width - 180,
            height: 25,
            child: const Center(
              child: Text('Set Profile Photo'),
            ),
          ),
          Image.network(userProfile.profilePhotoUrl),
          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTp2sgLeB4N7WAzCKQY4A5v1QdAzfR7fOjbaZMohajK_Q&s'),
              ),
              Positioned(
                bottom: -10,
                left: 90,
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.add_a_photo)
                )
              )
            ],
          ),
          Text('Logged in user: ${FirebaseAuth.instance.currentUser!.email!}'),
          MaterialButton(
          onPressed: (){
            service.getUserModelDataByEmail(FirebaseAuth.instance.currentUser!.email!, ref);
            showModalBottomSheet(
              context: context, 
              builder: ((context) => Column(
                children: [
                  const Text('Current user details: '),
                  Text('Email: ${user.email}'),
                  Text('Name: ${user.name}'),
                  Text('Country: ${user.countryName}'),
                ],
              ))
            );
          },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            minWidth: MediaQuery.of(context).size.width - 180,
            height: 25,
            child: Center(
              child: Text('Click to get current user data'),
            ),
          ),    
        ],
      ),
    );
  }
}