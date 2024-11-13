import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SST extends StatelessWidget {
  const SST({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SST'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('object');
          GoRouter.of(context).go('/sst/add_sms');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
