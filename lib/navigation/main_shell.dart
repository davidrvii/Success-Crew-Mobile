/// File: lib/navigation/main_shell.dart
/// Generated Documentation for main_shell.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/di/service_locator.dart';
import '../core/storage/user_session.dart';

/// Class representing `MainShell`.
/// Auto-generated class documentation.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  /// Method `_onTap` returning `void`.
  /// Handles logic operations related to `_onTap`.
  void _onTap(BuildContext context, int index, bool isOwner) {
    int targetBranch = index;
    if (isOwner && index == 2) {
      targetBranch = 3; // Owner's 3rd tab maps to branch index 3 (Crew)
    }
    navigationShell.goBranch(
      targetBranch,
      initialLocation: targetBranch == navigationShell.currentIndex,
    );
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: sl<UserSession>().readSession(),
      builder: (context, snapshot) {
        final session = snapshot.data;
        final roleName = session?['role_name']?.toString() ?? 'Teknisi';
        final isOwner = roleName.trim().toLowerCase() == 'owner';

        final navItems = [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_rounded),
            activeIcon: Icon(Icons.people_rounded),
            label: 'Pengunjung',
          ),
          if (isOwner)
            const BottomNavigationBarItem(
              icon: Icon(Icons.badge_outlined),
              activeIcon: Icon(Icons.badge_rounded),
              label: 'Crew',
            )
          else
            const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today_rounded),
              label: 'Absensi',
            ),
        ];

        int activeIndex = 0;
        if (isOwner) {
          if (navigationShell.currentIndex == 0) {
            activeIndex = 0;
          } else if (navigationShell.currentIndex == 1) {
            activeIndex = 1;
          } else if (navigationShell.currentIndex == 3) {
            activeIndex = 2;
          }
        } else {
          if (navigationShell.currentIndex == 0) {
            activeIndex = 0;
          } else if (navigationShell.currentIndex == 1) {
            activeIndex = 1;
          } else if (navigationShell.currentIndex == 2) {
            activeIndex = 2;
          }
        }

        return Scaffold(
          appBar: navigationShell.currentIndex == 2
              ? null
              : AppBar(
                  backgroundColor: const Color(0xFFF8F9FE),
                  elevation: 0,
                  titleSpacing: 0,
                  scrolledUnderElevation: 0,
                  title: const Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      'Success Comp',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C5AA6),
                      ),
                    ),
                  ),
                  centerTitle: true,
                ),
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: activeIndex,
            onTap: (i) => _onTap(context, i, isOwner),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF1C85E8),
            unselectedItemColor: const Color(0xFF64748B),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
            items: navItems,
          ),
        );
      },
    );
  }
}
