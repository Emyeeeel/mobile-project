import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/models/photo_model.dart';
import 'package:pinterest_clone/providers/providers.dart';
import 'package:pinterest_clone/widgets/main_page.dart';

import '../services/services.dart';
import '../styles.dart';

class PinImage extends ConsumerWidget {
  const PinImage({super.key, required this.photo});

  final UnsplashPhoto photo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-90,
            child: Image.network(photo.photoUrl, fit: BoxFit.cover,)
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
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: GestureDetector(
                    onTap: () {
                        showModalBottomSheet(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
                        context: context, 
                        builder: ((context) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                              color: Color(0xFF1E1E1E),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  const SizedBox(width: 20,),
                                  const Text('Comments', style: AppStyle.detailsSubtitlePin),
                                  const Spacer(),
                                  Text('$photo.likes', style: AppStyle.detailsSubtitlePin),
                                  const SizedBox(width: 5,),
                                  const Icon(Icons.favorite_border_outlined, color: Colors.white, size: 20,),
                                  const SizedBox(width: 20,),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              const Divider(
                                color: Colors.white
                              ),
                              const Spacer(),
                              const Divider(
                                color: Colors.white
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width - 40,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(width: 2, color: Colors.white), 
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            onChanged: (value) {
                                    
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Add a comment',
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const Icon(Icons.emoji_emotions_rounded, color: Colors.white, size: 25,),
                                        const SizedBox(width: 5,),
                                        const Icon(Icons.photo_album_rounded, color: Colors.white, size: 25,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,)
                            ],
                          ),
                        )
                      ));
                    },
                    child: SizedBox(
                      child: Center(child: Image.asset('lib/assets/Heart.png', width: 25, height: 25,))),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
                      context: context, 
                      builder: ((context) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                            color: Color(0xFF1E1E1E),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 50,),
                            const Row(
                              children: [
                                 SizedBox(width: 15,),
                                 Text('More options', style: AppStyle.detailsSubtitlePin),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            const Row(
                              children: [
                                 SizedBox(width: 15,),
                                 Text('Search visually similiar', style: AppStyle.detailsTitlePin),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            const Row(
                              children: [
                                 SizedBox(width: 15,),
                                 Text('Send', style: AppStyle.detailsTitlePin),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            const Row(
                              children: [
                                 SizedBox(width: 15,),
                                 Text('Download image', style: AppStyle.detailsTitlePin),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            const Row(
                              children: [
                                 SizedBox(width: 15,),
                                 Text('Copy link', style: AppStyle.detailsTitlePin),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            const Row(
                              children: [
                                 SizedBox(width: 15,),
                                 Text('Report Pin', style: AppStyle.detailsTitlePin),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            const Row(
                              children: [
                                 SizedBox(width: 15,),
                                 Text('Hide', style: AppStyle.detailsTitlePin),
                              ],
                            ),
                            const Spacer(),
                            MaterialButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              minWidth: 125,
                              height: 55,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              color: const Color(0xFF4C4C4C),
                              child: const Text('Close', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFA3A3A3)),),
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      )
                    ));
                  },
                  child: const ViewButton()
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      }
                    );
                    ref.read(pinNotifierProvider.notifier).setuserId(ref.read(userProfileNotifierProvider).userId.trim());
                    ref.read(pinNotifierProvider.notifier).setCreatedBy(photo.photographerUsername.trim());
                    ref.read(pinNotifierProvider.notifier).setUrl(photo.photoUrl.trim());
                    ref.read(pinNotifierProvider.notifier).setDescription(photo.description.trim());
                    final service = ref.watch(backendeServicesProvider);
                    service.sendPinData(ref);
                    service.updatePinUIDAndSave(ref);
                    Navigator.pop(context);
                  },
                  child: const SaveButton()
                ),
                const Spacer(),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
                        context: context, 
                        builder: ((context) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2 - 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                              color: Color(0xFF1E1E1E),
                          ),
                          child: const Column(
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Icon(Icons.close_rounded, size: 25, color: Colors.white, weight: 5,),
                                  Spacer(),
                                  Text('Share', style: AppStyle.detailsTitlePin,),
                                  Spacer(),
                                  SizedBox(width: 20,),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Apps(text: 'Copy',),
                                  Spacer(),
                                  Apps(text: 'Messenger',),
                                  Spacer(),
                                  Apps(text: 'Messages',),
                                  Spacer(),
                                  Apps(text: 'Facebook',),
                                  SizedBox(width: 20,),
                                ],
                              ),
                              SizedBox(height: 40,),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Apps(text: 'X',),
                                  Spacer(),
                                  Apps(text: 'Telegram',),
                                  Spacer(),
                                  Apps(text: 'Messages',),
                                  Spacer(),
                                  Apps(text: 'More apps',),
                                  SizedBox(width: 20,),
                                ],
                              )
                            ],
                          ),
                        )
                      ));
                    },
                    child: SizedBox(child: Center(child: Image.asset('lib/assets/Upload.png', width: 25, height: 25,)))),
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

class Apps extends StatelessWidget {
  const Apps({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey
            ),
          ),
          const SizedBox(height: 5,),
          Center(child: Text(text, style: const TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}
