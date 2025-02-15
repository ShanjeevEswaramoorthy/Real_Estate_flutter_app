import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/utils/constant.dart';

class BottomNavigationUi extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavigationUi({super.key, required this.navigationShell});

  @override
  State<BottomNavigationUi> createState() => _BottomNavigationUiState();
}

class _BottomNavigationUiState extends State<BottomNavigationUi> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
          indicatorColor: COLOR_GREY,
          selectedIndex: widget.navigationShell.currentIndex,
          animationDuration: const Duration(seconds: 2),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: widget.navigationShell.goBranch,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'HOME'),
            NavigationDestination(icon: Icon(Icons.add), label: 'ADD'),
            NavigationDestination(icon: Icon(Icons.person), label: 'PROFILE')
          ]),
    );
  }
}

/*

 BottomNavigationBar(
        enableFeedback: true,
        elevation: 10,
        showUnselectedLabels: true,
        backgroundColor: COLOR_WHITE,
        selectedItemColor: COLOR_BLACK,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          if (value == 1) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddPostUi(),
            ));
          } else if (value == 2) {
            return;
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const LandingScreenUI(),
            ));
          }
        },
        items: const [
          BottomNavigationBarItem(
              label: 'HOME',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(label: 'ADD', icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: 'PROFILE', icon: Icon(Icons.person))
        ]);
 */
