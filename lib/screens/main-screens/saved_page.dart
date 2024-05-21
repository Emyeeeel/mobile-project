import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
