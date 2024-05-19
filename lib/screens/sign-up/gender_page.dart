import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/screens/sign-up/interested_in_page.dart';
import 'package:pinterest_clone/screens/sign-up/location_page.dart';
import 'package:pinterest_clone/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';

import '../../providers/user_providers.dart';

class GenderPage extends ConsumerWidget {
  GenderPage({Key? key}) : super(key: key);

  final TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('What\'s your gender?', style: TextStyle(color: Colors.black, fontSize: 22),),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.fromLTRB(20,0,20,0),
              child: Text('This helps us find you more relevant content. We won’t show it on your profile', style: TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), 
                borderRadius: BorderRadius.circular(50),
              ),
              child: MaterialButton(
                onPressed: (){},
                minWidth: MediaQuery.of(context).size.width - 80,
                height: 50,
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                ),
                child: Text('Female', style: TextStyle(color: Colors.black, fontSize: 18),),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), 
                borderRadius: BorderRadius.circular(50),
              ),
              child: MaterialButton(
                onPressed: (){},
                minWidth: MediaQuery.of(context).size.width - 80,
                height: 50,
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                ),
                child: Text('Male', style: TextStyle(color: Colors.black, fontSize: 18),),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), 
                borderRadius: BorderRadius.circular(50),
              ),
              child: MaterialButton(
                onPressed: (){},
                minWidth: MediaQuery.of(context).size.width - 80,
                height: 50,
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                ),
                child: Text('Specify Another', style: TextStyle(color: Colors.black, fontSize: 18),),
              ),
            ),
          ],
        );
  }
}
