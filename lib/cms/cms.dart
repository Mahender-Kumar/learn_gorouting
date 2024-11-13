import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_gorouting/sms/sms1.dart';
import 'package:learn_gorouting/sms/sms2.dart';
import 'package:learn_gorouting/sms/sms3.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CMS extends StatefulWidget {
  final String currentPath;
  const CMS({
    super.key,
    required this.currentPath,
  });

  @override
  State<CMS> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CMS> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    int index = widget.currentPath == '/cms/cms3'
        ? 2
        : widget.currentPath == '/cms/cms2'
            ? 1
            : 0;
    _tabController.index = index;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int index = currentPath == '/sms/sms3'
    //     ? 2
    //     : currentPath == '/sms/sms2'
    //         ? 1
    //         : 0;
    //  navList.indexWhere(
    //   (e) => e['path'] != '/' && currentPath.startsWith(e['path']),
    // );
    // int selectedIndex = index == -1 ? 0 : index;
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(
              child: Text('SMS1'),
            ),
            Tab(
              child: Text('SMS2'),
            ),
            Tab(
              child: Text('SMS3'),
            ),
          ],
          onTap: (value) {
            switch (value) {
              case 0:
                GoRouter.of(context).go('/sms/sms1');
                print('SMS1');
                break;
              case 1:
                GoRouter.of(context).go('/sms/sms2');
                break;
              case 2:
                GoRouter.of(context).go('/sms/sms3');
                break;
              default:
            }
          },
        ),
        title: const Text('Safety Management System'),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SMS1(),
          const SMS2(),
          const SMS3(),
        ],
      ),
    );
  }
}
