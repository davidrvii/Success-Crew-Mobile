import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'go_router_config.dart';

/// Main shell untuk bottom navigation.
///
/// Step 1:
/// - Shell menyatukan 3 tab utama (Home/Visitor/Absence)
/// - Masih placeholder (page real kita pasang di step berikutnya)
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    // goBranch mempertahankan state masing-masing tab.
    // Jika reselect tab yang sama, set initialLocation=true supaya balik ke root tab tsb.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  String _titleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Visitor';
      case 2:
        return 'Absence';
      default:
        return 'Success Crew';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleForIndex(navigationShell.currentIndex)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Ke Home',
            onPressed: () => context.go(AppGoRouter.home),
            icon: const Icon(Icons.home_outlined),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (i) => _onTap(context, i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route_rounded),
            label: 'Visitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint_rounded),
            label: 'Absence',
          ),
        ],
      ),
    );
  }
}
