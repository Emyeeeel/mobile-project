import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ui_providers.dart';
import '../providers/user_providers.dart';
import '../screens/main-screens/home_page.dart';
import '../screens/main-screens/create_page.dart';
import '../screens/main-screens/inbox_page.dart';
import '../screens/main-screens/saved_page.dart';
import '../screens/main-screens/search_page.dart';
import '../screens/main-screens/test_page.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SearchPage(),
    const CreatePage(),
    const InboxPage(),
    const SavedPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final provider = ref.watch(userServicesProvider);
    provider.getCurrentUserDetails(ref);
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
                ref.watch(createPinUIProvider).showCreatePanel(context);
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
                child: Text(user.name!.substring(0, 1), style: TextStyle(color: Colors.white),),
              ),
            ),
            activeIcon: Icon(Icons.circle, color: Color(0xFF111111)),
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
}
