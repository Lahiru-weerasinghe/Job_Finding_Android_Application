import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkup/constants.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  String _route = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 4) {
      Navigator.pushNamed(context, "/profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[800],
            width: 1.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: colorDarkMidGround,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const Icon(Icons.badge, color: Colors.white)
                : const Icon(Icons.badge_outlined),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(Icons.book, color: Colors.white)
                : const Icon(Icons.book_outlined, color: Colors.white),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(Icons.add, color: Colors.white)
                : const Icon(Icons.add_outlined, color: Colors.white),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(FontAwesomeIcons.briefcase, color: Colors.white)
                : const Icon(Icons.bookmark_outline, color: Colors.white),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? const Icon(Icons.person, color: Colors.white)
                : const Icon(Icons.person_outline, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
