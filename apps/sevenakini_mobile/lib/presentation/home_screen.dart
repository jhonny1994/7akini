import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sevenakini_mobile/presentation/widgets/app_drawer.dart';
import 'package:sevenakini_mobile/presentation/widgets/message_bubble.dart';
import 'package:sevenakini_mobile/providers/messages_stream_provider.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authStateNotifierProvider.notifier).user;
    final messagesStream = ref.watch(messagesStreamProvider);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Messages'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Iconsax.menu_1),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: messagesStream.when(
        data: (messages) => messages.isEmpty
            ? const EmptyScreen()
            : ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages.elementAt(index);
                  return MessageBubble(message: message, user: user);
                },
              ),
        error: (error, stackTrace) => ErrorScreen(message: error.toString()),
        loading: () => const LoadingScreen(),
      ),
    );
  }
}
