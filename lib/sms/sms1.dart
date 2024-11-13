import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_gorouting/app_router.dart';

class SMS1 extends StatelessWidget {
  const SMS1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS1'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print('object');
          GoRouter.of(context).go('/sms/sms1/add_sms');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
