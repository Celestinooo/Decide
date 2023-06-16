import 'package:decide/tabs/views/tab/home_tab.dart';
import 'package:decide/tabs/views/tab/notifications_tab.dart';
import 'package:decide/tabs/views/tab/create_tab.dart';
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
    const NotificationsTab(),
    const ProfileTab(),
  ];

  void _onItemTapped(int index) {
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
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active),
                label: 'Notificações',
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
