import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.message,
    super.key,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(message),
            TextButton(
              onPressed: () {
                //TODO: implicit retry
              },
              child: const Text('retry'),
            ),
          ],
        ),
      ),
    );
  }
}
