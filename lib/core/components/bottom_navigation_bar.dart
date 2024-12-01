import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabSelected,
      backgroundColor: Colors.blueGrey, // Set a contrasting background color
      selectedItemColor: Colors.indigo, // Highlight color for selected item
      unselectedItemColor: Colors.black45, // Color for unselected items
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.upload_file),
          label: 'File Import',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Clients',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Upcoming Renewals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Agent',
        ),
      ],
    );
  }
}
