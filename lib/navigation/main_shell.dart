import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FE),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Success Comp',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C5AA6),
          ),
        ),
        centerTitle: true,
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
