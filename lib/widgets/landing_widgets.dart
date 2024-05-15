import 'package:flutter/material.dart';

class LandingPageWidget extends StatelessWidget {
  const LandingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50,),
          const Text('Welcome to Pinterest'),
          const SizedBox(height: 20,),
          MaterialButton(
            onPressed: (){
              
            },
            minWidth: MediaQuery.of(context).size.width - 80,
            height: 50,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text('Sign up'),
          ),
          const SizedBox(height: 10,),
          MaterialButton(
            onPressed: (){

            },
            minWidth: MediaQuery.of(context).size.width - 80,
            height: 50,
            color: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text('Log in'),
          ),
          const SizedBox(height: 15,),
          const Text(
            'By continuing, you agree to Pinterest’s Terms of Service and acknowledge you\'ve read our Privacy Policy. Notice at collection',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
