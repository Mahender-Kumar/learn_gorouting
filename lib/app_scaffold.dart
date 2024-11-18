import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_gorouting/test2.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppScaffold extends ConsumerWidget {
  AppScaffold({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  final List<Widget> children;

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  int mobileNavs = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> navList = [];

    // Initial dashboard item

    // Function to add items to navList based on permissions
    void addItem(String module, Icon icon, Icon selectedIcon, String label,
        String path) {
      // if (userAccess.any((permission) => permission['module'] == module) ||
      //     module == 'DA') {
      navList.add({
        'icon': icon,
        'selectedIcon': selectedIcon,
        'label': label,
        'path': path,
      });
      // }
    }

    // Adding items to navList using the addItem function
    addItem('SM', const Icon(Icons.book_outlined), const Icon(Icons.book),
        'SMS', '/sms');
    addItem('AM', const Icon(Icons.book_outlined), const Icon(Icons.book), 'AM',
        '/cms/a');

    addItem('CM', const Icon(Icons.account_circle_outlined),
        const Icon(Icons.account_circle), 'CMS', '/cms');
    addItem('SS', const Icon(Icons.apartment_outlined),
        const Icon(Icons.apartment), 'SST', '/sst');

    // int index = navList.indexWhere(
    //   (e) => e['path'] != '/' && currentPath.startsWith(e['path']),
    // );
    // int selectedIndex = index == -1 ? 0 : index;

    return AdaptiveLayout(
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Primary Navigation Medium'),
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              extended: false,
              width: 88,
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => GoRouter.of(context).go('/'),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    radius: 24,
                    // backgroundImage: const AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
              trailing: Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    ListTile(
                      title: FutureBuilder<PackageInfo>(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            return Text('v${snapshot.data?.version}',
                                style: Theme.of(context).textTheme.bodySmall);
                          }),
                    ),
                  ],
                ),
              ),
              destinations: [
                ...navList.map(
                  (e) => NavigationRailDestination(
                    icon: e['icon'],
                    selectedIcon: e['selectedIcon'],
                    label: Text(
                      e['label'],
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (int index) => _onTap(context, index),
              //  (index) async {
              //   // if (navList[index]['path'] == '/logout') {
              //   //   await FirebaseAuth.instance.signOut();
              //   //   return;
              //   // }
              //   GoRouter.of(context).go(navList[index]['path'] ?? '/');
              // },
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              padding: const EdgeInsets.all(0),
            ),
          ),
        },
      ),
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.smallAndUp: SlotLayout.from(
            key: const Key('Body All'),
            builder: (_) => AnimatedBranchContainer(
              currentIndex: navigationShell.currentIndex,
              children: children,
            ),
          ),
        },
      ),
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Bottom Navigation Small'),
            builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: [
                ...navList.take(mobileNavs).map(
                      (e) => NavigationDestination(
                        icon: e['icon'],
                        selectedIcon: e['selectedIcon'],
                        label: e['label'],
                      ),
                    ),
                if (navList.length > mobileNavs)
                  const NavigationDestination(
                    icon: Icon(Icons.more_horiz_outlined),
                    selectedIcon: Icon(Icons.more_horiz),
                    label: 'More',
                  ),
              ],
              currentIndex: navigationShell.currentIndex >= mobileNavs
                  ? mobileNavs
                  : navigationShell.currentIndex,
              onDestinationSelected: (index) {
                if (index == mobileNavs) {
                  showModalBottomSheet(
                    showDragHandle: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    useRootNavigator: true,
                    context: context,
                    builder: (BuildContext context) {
                      return LayoutBuilder(builder: (context, constraints) {
                        final maxHeight =
                            MediaQuery.of(context).size.height * 0.9;
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: maxHeight),
                          child: ListView(
                            shrinkWrap: true,
                            children: navList.skip(mobileNavs).map((e) {
                              return ListTile(
                                dense: true,
                                selected: e['path'] ==
                                    navList[navigationShell.currentIndex]
                                        ['path'],
                                title: Text(e['label']),
                                leading: e['icon'],
                                onTap: () {
                                  if (e['path'] == '/logout') {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Logout'),
                                          content: const Text(
                                              'Are you sure you want to logout?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // // await FirebaseAuth.instance
                                                // //     .signOut();
                                                // if (context.mounted) {
                                                //   Navigator.pop(context);
                                                //   context.pop();
                                                // }
                                              },
                                              child: const Text('Logout'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.pop(context);
                                    GoRouter.of(context).go(e['path']);
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        );
                      });
                    },
                  );
                } else {
                  GoRouter.of(context).go(navList[index]['path'] ?? '/');
                }
              },
            ),
          )
        },
      ),
    );
  }

  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class AnimatedBranchContainer extends StatelessWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (int index, Widget navigator) {
        return AnimatedScale(
          scale: index == currentIndex ? 1 : 1.5,
          duration: const Duration(milliseconds: 400),
          child: AnimatedOpacity(
            opacity: index == currentIndex ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            child: _branchNavigatorWrapper(index, navigator),
          ),
        );
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}
