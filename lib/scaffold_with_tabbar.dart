import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_gorouting/sms/sms1.dart';
import 'package:learn_gorouting/sms/sms2.dart';
import 'package:learn_gorouting/sms/sms3.dart';

// class ScaffoldWithNavBar extends StatefulWidget {
//   final String currentPath;
//   const ScaffoldWithNavBar({
//     super.key,
//     required this.currentPath,
//   });

//   @override
//   State<ScaffoldWithNavBar> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<ScaffoldWithNavBar>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     int index = widget.currentPath == '/sms/sms3'
//         ? 2
//         : widget.currentPath == '/sms/sms2'
//             ? 1
//             : 0;
//     _tabController.index = index;
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // int index = currentPath == '/sms/sms3'
//     //     ? 2
//     //     : currentPath == '/sms/sms2'
//     //         ? 1
//     //         : 0;
//     //  navList.indexWhere(
//     //   (e) => e['path'] != '/' && currentPath.startsWith(e['path']),
//     // );
//     // int selectedIndex = index == -1 ? 0 : index;
//     return Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: true,
//           tabAlignment: TabAlignment.start,
//           tabs: [
//             Tab(
//               child: Text('SMS1'),
//             ),
//             Tab(
//               child: Text('SMS2'),
//             ),
//             Tab(
//               child: Text('SMS3'),
//             ),
//           ],
//           onTap: (value) {
//             switch (value) {
//               case 0:
//                 GoRouter.of(context).go('/sms/sms1');
//                 print('SMS1');
//                 break;
//               case 1:
//                 GoRouter.of(context).go('/sms/sms2');
//                 break;
//               case 2:
//                 GoRouter.of(context).go('/sms/sms3');
//                 break;
//               default:
//             }
//           },
//         ),
//         title: const Text('Safety Management System'),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           const SMS1(),
//           const SMS2(),
//           const SMS3(),
//         ],
//       ),
//     );
//   }
// }

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: navigationShell.currentIndex,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Section A', icon: Icon(Icons.home)),
              Tab(text: 'Section B', icon: Icon(Icons.home)),
            ],
            onTap: _goBranch,
          ),
        ),
        body: navigationShell,
        // bottomNavigationBar: NavigationBar(
        //   selectedIndex: navigationShell.currentIndex,
        //   destinations: const [
        //     NavigationDestination(label: 'Section A', icon: Icon(Icons.home)),
        //     NavigationDestination(label: 'Section B', icon: Icon(Icons.settings)),
        //   ],
        //   onDestinationSelected: _goBranch,
        // ),
      ),
    );
  }
}

class ScaffoldWithNestedNavigation2 extends StatelessWidget {
  final List<Widget> children;
  const ScaffoldWithNestedNavigation2({
    Key? key,
    required this.navigationShell,
    required this.children,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: navigationShell.currentIndex,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Sectaion A', icon: Icon(Icons.home)),
              Tab(text: 'Sectaion B', icon: Icon(Icons.home)),
            ],
            onTap: _goBranch,
          ),
        ),
        body: navigationShell,
        // bottomNavigationBar: NavigationBar(
        //   selectedIndex: navigationShell.currentIndex,
        //   destinations: const [
        //     NavigationDestination(label: 'Section A', icon: Icon(Icons.home)),
        //     NavigationDestination(label: 'Section B', icon: Icon(Icons.settings)),
        //   ],
        //   onDestinationSelected: _goBranch,
        // ),
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab root - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go(detailsPath),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
