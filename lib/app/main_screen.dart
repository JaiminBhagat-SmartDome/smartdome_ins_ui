import 'package:flutter/material.dart';
import 'package:smartdome_ins_ui/features/agent/views/agent_view_screen.dart';
import 'package:smartdome_ins_ui/features/client/views/client_list_screen.dart';
import 'package:smartdome_ins_ui/features/upcoming_renewals/views/renewals_screen.dart';
import '../core/components/bottom_navigation_bar.dart';
import '../features/file_import/views/file_import_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    FileImportScreen(),
    ClientsScreen(),
    UpcomingRenewalsScreen(),
    AgentScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
