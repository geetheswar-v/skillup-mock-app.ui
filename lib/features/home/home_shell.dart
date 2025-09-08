import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../pages/account_page.dart';
import '../pages/analysis_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/tests_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  final _pages = const [
    DashboardPage(),
    TestsPage(),
    AnalysisPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => _MobileScaffold(
        index: _index,
        onTap: (i) => setState(() => _index = i),
        child: _pages[_index],
      ),
      tablet: (_) => _DesktopScaffold(
        index: _index,
        onSelect: (i) => setState(() => _index = i),
        child: _pages[_index],
      ),
      desktop: (_) => _DesktopScaffold(
        index: _index,
        onSelect: (i) => setState(() => _index = i),
        child: _pages[_index],
      ),
    );
  }
}

class _MobileScaffold extends StatelessWidget {
  final int index;
  final Widget child;
  final ValueChanged<int> onTap;
  const _MobileScaffold({required this.index, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SkillUP')),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Tests'),
          BottomNavigationBarItem(icon: Icon(Icons.insights_outlined), label: 'Analysis'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}

class _DesktopScaffold extends StatelessWidget {
  final int index;
  final Widget child;
  final ValueChanged<int> onSelect;
  const _DesktopScaffold({required this.index, required this.child, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Dashboard', Icons.dashboard),
      ('Tests', Icons.assignment),
      ('Analysis', Icons.insights),
      ('Account', Icons.person),
    ];

    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 64,
              child: Row(
                children: [
                  const Text('SkillUP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(items.length, (i) {
                          final selected = i == index;
                          final (label, icon) = items[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextButton.icon(
                              onPressed: () => onSelect(i),
                              icon: Icon(icon, color: selected ? Theme.of(context).colorScheme.primary : null),
                              label: Text(label, style: TextStyle(color: selected ? Theme.of(context).colorScheme.primary : null)),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }
}
