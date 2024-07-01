import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              ref.read(authStateNotifierProvider.notifier).signOut(),
          icon: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
