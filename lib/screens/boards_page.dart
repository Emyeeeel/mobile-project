import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/providers.dart';
import 'package:pinterest_clone/styles.dart';
import 'package:provider/provider.dart';

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

