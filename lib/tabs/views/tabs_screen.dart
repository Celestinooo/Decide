import 'package:decide/tabs/stores/following_store.dart';
import 'package:decide/tabs/stores/profile_store.dart';
import 'package:decide/tabs/stores/search_store.dart';
import 'package:decide/tabs/views/tab/home_tab.dart';
import 'package:decide/tabs/views/tab/search_tab.dart';
import 'package:decide/tabs/views/tab/create_tab.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:decide/tabs/views/tab/profile_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeTab(),
    const SearchTab(),
    const ProfileTab(),
  ];

  void _onItemTapped(int index) {
    if(index == 0) {
      final followingStore = Modular.get<FollowingStore>();
      followingStore.getCharts();
    }
    if(index == 2) {
      final profileStore = Modular.get<ProfileStore>();
      profileStore.getProfile();
      profileStore.getCharts();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.feed),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Buscar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
