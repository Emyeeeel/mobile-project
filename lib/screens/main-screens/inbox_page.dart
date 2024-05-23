import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/providers/user_providers.dart';
import 'package:pinterest_clone/services/user_services.dart';

import '../../providers/auth_providers.dart';
import '../../providers/pinterest_user_provider.dart';

class InboxPage extends ConsumerWidget {
  const InboxPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Center(child: Text('data'))
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
        future: ref.watch(pinterestServicesProvider).getCurrentPinterestUserDetails(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final service = ref.watch(pinterestServicesProvider);
            final user = ref.read(pinterestUserProvider);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User index: ${service.userIndex.toString()}'),
                  Text('Pinterest User index: ${service.pinterestUserIndex.toString()}'),
                  Text('User docID: ${service.userTableDocIds[service.userIndex]}'),
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
                  Text('Contacts: ${user.contacts!.length}'),
                  Text('Followers: ${user.followers!.length}'),
                  Text('Following: ${user.following!.length}'),
                  Text('ProfilePhoto URL: ${user.profilePhotoURL}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
