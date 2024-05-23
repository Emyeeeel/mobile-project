import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/user_providers.dart';
import 'package:pinterest_clone/services/user_services.dart';

import '../../providers/auth_providers.dart';
import '../../providers/pinterest_user_provider.dart';

class InboxPage extends ConsumerWidget {
  const InboxPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(pinterestServicesProvider);
    final auth = ref.watch(authServicesProvider);
    final user = ref.read(userProvider);
    final pinterestUser = ref.read(pinterestUserProvider);
    service.checkUser();
    service.getCurrentPinterestUserDetails(ref);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text('Is user in pinterest_user? ${service.isUserInPinterestUserTable.toString()}'),
        ),
        const SizedBox(height: 10,),
        Center(
          child: Column(
            children: [
              const Text('User Table info: '),
              Text('${service.currentUserData['name']}'),
              Text('${service.currentUserData['email']}'),
              Text('${service.currentUserData['password']}'),
              Text('${service.currentUserData['gender']}'),
              Text('${service.currentUserData['location']}'),
              Text('${service.currentUserData['dateOfBirth']}'),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Center(
          child: Column(
            children: [
              const Text('Pinterest User Table info: '),
              Text('${service.pinterestUserInfoList[service.pinterestUserIndex]['userId']}'),
              Text('${service.currentPinterestUserData['userName']}'),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Center(
          child: Column(
            children: [
              const Text('Pinterest User using user provider: '),
              Text('${user.name}'),
              Text('${user.email}'),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Center(
          child: Column(
            children: [
              const Text('Pinterest User using pinterest user provider: '),
              Text('${pinterestUser.currentUser!.name}'),
              Text('${pinterestUser.currentUser!.email}'),
              Text('${pinterestUser.userName}'),
              Text('${pinterestUser.profilePhotoURL}'),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Center(
          child: MaterialButton(
            onPressed: () {
                service.sendUsersDataToPinterestTable(ref);
            },
            minWidth: 150,
              height: 55,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Color.fromARGB(255, 172, 172, 172),
            child: Text('Send User Info',),
          ),
        ),
        const SizedBox(height: 30,),
        Center(
          child: MaterialButton(
            onPressed: () {
                auth.signUserOut(context, ref);
            },
            minWidth: 125,
              height: 55,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Color.fromARGB(255, 172, 172, 172),
            child: Text('Logout',),
          ),
        ),
      ],
    );
  }
}

class DumpPage extends ConsumerWidget {
  const DumpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: FutureBuilder<void>(
        future: ref.watch(testServicesProvider).getCurrentPinterestUserDetails(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator while the data is being fetched
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error case
            return Text('Error: ${snapshot.error}');
          } else {
            final service = ref.watch(testServicesProvider);
            final user = ref.read(pinterestUserProvider);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User index: ${service.userIndex.toString()}'),
                  Text('Pinterest User index: ${service.pinterestUserIndex.toString()}'),
                  Text('User docID: ${service.userTableDocIds[service.userIndex]}'),
                  Text('Pinterest User userID: ${service.pinterestUserTableInfoList[service.pinterestUserIndex]['userID']}'),
                  Text('Pinterest User profilePhoto: ${service.pinterestUserTableInfoList[service.pinterestUserIndex]['profilePhoto']}'),
                  const SizedBox(height: 50,),
                  Text('Pinterest User Name: ${user.currentUser!.name}'),
                  Text('Pinterest User Username: ${user.userName}'),
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
