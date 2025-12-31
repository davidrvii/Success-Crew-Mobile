import 'package:flutter/material.dart';
//import '../../features/home/presentation/pages/home_page.dart';
//import '../../features/visitor_tracker/presentation/pages/visit_page.dart';
//import '../../features/attendance/presentation/pages/absence_page.dart';

class BottomNavPage extends StatefulWidget {
  final int initialIndex;
  const BottomNavPage({super.key, this.initialIndex = 0});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  late int _index;

  final List<Widget> _pages = const [
    //HomePage(),

    //VisitorTrackerPage(),

    //AttendancePage(),
  ];

  final List<String> _titles = const ['Home', 'Visitor', 'Absence'];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, _pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index]), centerTitle: true),

      body: IndexedStack(index: _index, children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
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
