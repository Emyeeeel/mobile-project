import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/models/country_state_repo.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/screens/landing_page.dart';
import 'package:pinterest_clone/widgets/button.dart';

import 'package:pinterest_clone/models/country_state.dart' as cs_model;
import 'package:http/http.dart' as http;

class LocationsPage extends ConsumerWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text('Where do you live?', style: TextStyle(color: Colors.black, fontSize: 22),),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.fromLTRB(20,0,20,0),
              child: Text('This helps us find you more relevant content. We won’t show it on your profile', style: TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 30,),
      ],
    );
  }
}
