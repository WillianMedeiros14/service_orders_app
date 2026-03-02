import 'package:flutter/material.dart';
import 'package:service_orders_app/features/home/presentation/pages/home_page.dart';
import 'package:service_orders_app/features/profile/presentation/pages/profile_page.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _pages[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  topRight: Radius.circular(60.0),
                  bottomLeft: Radius.circular(60.0),
                  bottomRight: Radius.circular(60.0),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  iconSize: 40,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,

                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: const Color.fromARGB(96, 54, 53, 53),

                  selectedLabelStyle: TextStyle(color: AppColors.primary),
                  unselectedLabelStyle: const TextStyle(
                    color: Color.fromARGB(96, 54, 53, 53),
                  ),

                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Perfil',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
