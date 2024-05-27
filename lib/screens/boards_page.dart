import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/providers/providers.dart';
import 'package:pinterest_clone/styles.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import '../widgets/main_page.dart';

class CreateBoardPage extends ConsumerWidget {
  CreateBoardPage({super.key});
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
          },
          child: const Icon(Icons.close_rounded)),
        toolbarHeight: 120,
        title: Row(
          children: [
            const Spacer(),
            const Text('Create board'),
            const Spacer(),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(
                  context: context, 
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
                  builder: (context) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                      color: Color(0xFF1E1E1E),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        const Row(
                          children: [
                            SizedBox(width: 20,),
                            Spacer(),
                            Text('Select Photos', style: AppStyle.detailsTitlePin,),
                            Spacer(),
                            SizedBox(width: 20,),
                          ],
                        ),
                        const SizedBox(height: 50,),
                          SizedBox(
                            height: 300,
                            width: MediaQuery.of(context).size.width-40,
                          child: Expanded(
                            child: SizedBox(
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,),
                                itemCount: ref.read(backendeServicesProvider).urls.length, 
                                itemBuilder: (BuildContext context, int index) {
                                  bool isSelected = ref.read(boardNotifierProvider).pinIds.contains(ref.read(backendeServicesProvider).urls[index]);
                                  return GestureDetector(
                                    onTap: () {
                                      ref.watch(boardNotifierProvider.notifier).addPinId(ref.read(backendeServicesProvider).urls[index].trim());
                                      if (isSelected) {
                                        ref.watch(boardNotifierProvider.notifier).removePinId(ref.read(backendeServicesProvider).urls[index].trim());
                                      } else {
                                        ref.watch(boardNotifierProvider.notifier).addPinId(ref.read(backendeServicesProvider).urls[index].trim());
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: isSelected ? Colors.grey.shade300 : Colors.transparent, width: 2),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image.network(
                                              ref.read(backendeServicesProvider).urls[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },         
                              )
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: (){
                            ref.read(backendeServicesProvider).getBoard(ref);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                          },
                          minWidth: 80,
                          height: 55,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: const Color(0xFF404040),
                          child: const Text('Create', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFA3A3A3)),),
                        ),
                      ],
                    ),
                  )
                );
              },
              child: Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.red
                ),
                child: const Center(
                  child: Text('Create', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20,),
              Text('Board Name', style: AppStyle.detailsSubtitle,),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20,),
              Expanded(
                child: TextField(
                  controller: nameController,
                  onChanged: (value) {
                    ref.read(boardNotifierProvider.notifier).setName(value.trim());
                  },
                  decoration: const InputDecoration(
                    hintText: 'Give your board a title',
                    hintStyle: AppStyle.detailsTitle,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              const SizedBox(width: 20,),
              Text('Collaborators', style: AppStyle.detailsSubtitle,),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 20,),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey
                ),
                child: const Icon(Icons.person_add)
              ),
              SizedBox(width: 20,),
              Text('Invite friends', style: AppStyle.detailsTitle,),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              const SizedBox(width: 20,),
              Text('Privacy', style: AppStyle.detailsSubtitle,),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              const SizedBox(width: 20,),
              Text('Make this board secret', style: AppStyle.detailsTitle,),
              Spacer(),
              Icon(Icons.toggle_off, size: 50,),
              const SizedBox(width: 20,),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20,),
              Text('Only you and collaborators will see this board', style: AppStyle.detailsSubtitle,),
            ],
          ),
        ],
      ),
    );
  }
}


