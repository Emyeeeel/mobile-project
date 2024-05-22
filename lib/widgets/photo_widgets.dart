import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/providers/ui_providers.dart';
import 'package:pinterest_clone/widgets/main_page.dart';

class PinImage extends ConsumerWidget {
  const PinImage({super.key, required this.photoUrl});

  final String photoUrl;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-90,
            child: Image.network(photoUrl, fit: BoxFit.cover,)
          ),
        ),
        Positioned(
          top: 45,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                    },
                    child: const Icon(Icons.arrow_back_ios_rounded, size: 25, color: Color(0xFFD9D9D9),)
                  ),
                  const Spacer(),
                  Row(
                      children: List.generate(
                        3,
                        (index) => const Padding(
                          padding: EdgeInsets.all(1),
                          child: Icon(
                            Icons.circle,
                            size: 8,
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 90,
            color: const Color(0xFF2B2B2B),
            child: Row(
              children: [
                const SizedBox(width: 20,),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red
                  ),
                ),
                const Spacer(),
                const ViewButton(),
                const SizedBox(width: 10,),
                const SaveButton(),
                const Spacer(),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red
                  ),
                ),
                const SizedBox(width: 20,),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ViewButton extends StatelessWidget {
  const ViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                width: 95,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFF767676)
                ),
                child: Center(
                  child: Text(
                    'View', 
                    style: GoogleFonts.inter(
                              color: const Color(0xFFF2F2F2),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),),
                ),
              );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                width: 95,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFD32D2F)
                ),
                child: Center(
                  child: Text(
                    'Save', 
                    style: GoogleFonts.inter(
                              color: const Color(0xFFFEFAF3),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),),
                ),
              );
  }
}

