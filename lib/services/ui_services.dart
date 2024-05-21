import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../styles.dart';

class PasswordVisibilityNotifier extends StateNotifier<bool> {
  PasswordVisibilityNotifier() : super(false);

  void toggleVisibilityIcon() {
    state = !state;
  }
}

class PhotoDetails {
  displayDetails(BuildContext context, String username) { 
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.close_rounded, size: 25,),
                  SizedBox(width: 20,),
                  Text('Option', style: AppStyle.detailsTitle,)
                ],
              ),
              const SizedBox(height: 50,),
              Text('Follow $username', style: AppStyle.detailsTitle,),
              const SizedBox(height: 20,),
              const Text('Copy Link', style: AppStyle.detailsTitle,),
              const SizedBox(height: 20,),
              const Text('Download image', style: AppStyle.detailsTitle,),
              const SizedBox(height: 20,),
              const Text('Hide Pin', style: AppStyle.detailsTitle,),
              const Text('See fewer Pins like this', style: AppStyle.detailsSubtitle),
              const SizedBox(height: 20,),
              const Text('Report Pin', style: AppStyle.detailsTitle,),
              const Text('This goes against Pinterest\'s community guidelines', style: AppStyle.detailsSubtitle),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationService extends StateNotifier<int> {
  BottomNavigationService() : super(0);

  void setSelectedIndex(int index) {
    state = index;
  }
}

class CreatePin {
  showCreatePanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width - 150,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          color: Color(0xFF1E1E1E),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20,20,20,0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close_rounded, size: 30, color: Color(0xFFEFEFEF),)
                  ),
                  const Spacer(),
                  const Text('Start creating now', style: TextStyle(color: Color(0xFFEFEFEF), fontSize: 20, fontWeight: FontWeight.w600),),
                  const Spacer(),
                  const SizedBox(width: 30,)
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF616161)
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Center(child: Text('Pin', style: TextStyle(color: Color(0xFFEFEFEF), fontSize: 15, fontWeight: FontWeight.w500),))
                  ],
                ),
                const SizedBox(width: 20,),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF616161)
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Center(child: Text('Collage', style: TextStyle(color: Color(0xFFEFEFEF), fontSize: 15, fontWeight: FontWeight.w500),))
                  ],
                ),
                const SizedBox(width: 20,),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF616161)
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Center(child: Text('Board', style: TextStyle(color: Color(0xFFEFEFEF), fontSize: 15, fontWeight: FontWeight.w500),))
                  ],
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
          ],
        ),
      )
    );
  }
}