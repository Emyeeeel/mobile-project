import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/providers.dart';
import 'package:pinterest_clone/screens/main-screens/inbox_page.dart';
import 'package:pinterest_clone/screens/main-screens/search_page.dart';
import 'package:pinterest_clone/services/services.dart';
//import 'package:flutter/widgets.dart';

import '../providers/ui_providers.dart';
import '../screens/main-screens/home_page.dart';
import '../screens/main-screens/create_page.dart';
import '../screens/main-screens/saved_page.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    SearchPage(),
    const CreatePage(),
    InboxPage(),
    SavedPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final user = ref.watch(userModelNotifierProvider);
    return FutureBuilder<void>(
      future: ref.watch(backendeServicesProvider).getUserInfo(ref),
      builder: (context, snapshot) {
        return Scaffold(
          body: _widgetOptions.elementAt(selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled, color: Color(0xFF797979)),
                activeIcon: Icon(Icons.home_filled, color: Color(0xFF111111)),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Color(0xFF797979)),
                activeIcon: Icon(Icons.search, color: Color(0xFF111111)),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.add, color: Color(0xFF797979)),
                activeIcon: GestureDetector(
                  onTap: (){
                    ref.read(createPinUIProvider).showCreatePanel(context);
                  },
                  child: const Icon(Icons.add, color: Color(0xFF111111))),
                label: 'Create',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Color(0xFF797979)),
                activeIcon: Icon(Icons.chat, color: Color(0xFF111111)),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFF404040)
                  ),
                  child: Center(
                    child: Text(user.name.substring(0,1), style: const TextStyle(color: Colors.white),),
                  ),
                ),
                activeIcon: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFF111111)
                  ),
                  child: Center(
                    child: Text(user.name.substring(0,1), style: const TextStyle(color: Colors.white),),
                  ),
                ),
                label: 'Saved',
              ),
            ],
            currentIndex: selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (value) {
              ref.read(bottomNavigationProvider.notifier).setSelectedIndex(value);
            },
          ),
        );
      }
    );
  }
}
