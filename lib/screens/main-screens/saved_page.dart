import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/providers/auth_providers.dart';



class SavedPage extends ConsumerWidget {
  const SavedPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authServicesProvider);
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20,),
          const Row(
            children: [
              Spacer(),
              Icon(Icons.upload, size: 30,),
              SizedBox(width: 20,),
              Icon(Icons.settings, size: 30,),
              SizedBox(width: 20,),
            ],
          ),
          const SizedBox(height: 30,),
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xFF404040)
            ),
          ),
          const SizedBox(height: 10,),
          const Text('User Name', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
          Row(
            children: [
              const Spacer(),
              Center(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFF404040)
                  ),
                ),
              ),
              const Text(' username', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              const Text('0 followers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
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
              const Text('0 following', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
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
          MaterialButton(
            onPressed: (){
              auth.signUserOut(context, ref);
            },
            minWidth: 250,
            height: 80,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Colors.red,
            child: const Text('Sign out'),
          )
        ],
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<String> docIds = [];

  Future<void> getDocID() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    snapshot.docs.forEach((document) {
      docIds.add(document.reference.id);
    });
  }

  String userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Page')),
      body: Column(
        children: [
          Text('User Table: '),
          Expanded(
            child: FutureBuilder(
              future: getDocID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  // Check if docIds is empty before building ListView.builder
                  if (docIds.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: docIds.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: GetUserName(documentId: docIds[index]),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  GetUserName({Key? key, required this.documentId}) : super(key: key);

  final String documentId;
  Map<String, dynamic> data = {};
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          data = snapshot.data!.data() as Map<String, dynamic>;
          DateTime dateOfBirth = DateTime.parse(data['dateOfBirth']);
          List<dynamic> selectedTopicsDynamic = data['selectedTopics'] ?? [];
          List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
          UserModel currentUser = UserModel(
            email: data['email'], 
            password: data['password'], 
            name: data['name'], 
            dateOfBirth: dateOfBirth,
            gender: data['gender'], 
            location: data['location'], 
            selectedTopics: selectedTopics
          );
          return Text('Name: ${currentUser.name}\nEmail: ${currentUser.email}');
        }
        return Text('Loading...');
      },
    );
  }
}
