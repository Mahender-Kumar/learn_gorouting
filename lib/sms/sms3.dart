import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SMS3 extends StatelessWidget {
  final String detailsPath;
  const SMS3({
    super.key,
    required this.detailsPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('SMS3'),
          ],
        ),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).go(detailsPath);
            },
            child: const Text('View details'),
          ),
        ],
      ),
    );
  }
}
