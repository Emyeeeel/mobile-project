import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter/widgets.dart';

import '../providers/ui_providers.dart';
import '../screens/main-screens/home_page.dart';
import '../screens/main-screens/create_page.dart';
import '../screens/main-screens/inbox_page.dart';
import '../screens/main-screens/saved_page.dart';
import '../screens/main-screens/search_page.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    const SearchPage(),
    const CreatePage(),
    const InboxPage(),
    const SavedPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    return Scaffold(
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Color(0xFF797979)),
            activeIcon: Icon(Icons.home_filled, color: Color(0xFF111111)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Color(0xFF797979)),
            activeIcon: Icon(Icons.search, color: Color(0xFF111111)),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Color(0xFF797979)),
            activeIcon: Icon(Icons.add, color: Color(0xFF111111)),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Color(0xFF797979)),
            activeIcon: Icon(Icons.chat, color: Color(0xFF111111)),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle, color: Color(0xFF797979)),
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
