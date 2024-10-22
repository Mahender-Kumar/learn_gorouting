import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_gorouting/sms/sms1.dart';
import 'package:learn_gorouting/sms/sms2.dart';
import 'package:learn_gorouting/sms/sms3.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SMS extends ConsumerWidget {
  const SMS({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
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
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SMS1(),
            const SMS2(),
            const SMS3(),
          ],
        ),
      ),
    );
  }
}
