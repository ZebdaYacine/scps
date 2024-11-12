// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({super.key});

  @override
  _CustomNavigationRailState createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
          // Handle navigation or update the UI here
        });
      },
      labelType: NavigationRailLabelType.all,
      leading: const Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
                'assets/profile.jpg'), // Replace with your asset path
          ),
          SizedBox(height: 10),
          Text('User'),
        ],
      ),
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home),
          selectedIcon: Icon(Icons.home_filled),
          label: Text('Consile medical'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          selectedIcon: Icon(Icons.person),
          label: Text('Dossier medical'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          selectedIcon: Icon(Icons.settings),
          label: Text('code ald'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.logout),
          selectedIcon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
      ],
    );
  }
}
