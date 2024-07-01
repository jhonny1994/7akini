import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sevenakini_mobile/presentation/chat_screen.dart';
import 'package:sevenakini_mobile/presentation/widgets/app_drawer.dart';
import 'package:sevenakini_mobile/providers/chat_notifier_provider.dart';
import 'package:sevenakini_mobile/providers/users_stream_provider.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersStream = ref.watch(userStreamProvider);
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
      body: usersStream.when(
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users.elementAt(index);
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: CachedNetworkImageProvider(user.imageUrl!),
              ),
              title: Text(user.username),
              onTap: () async {
                final chatId = await ref.read(chatNotifierProvider).getChatId(
                      ref.read(authStateNotifierProvider.notifier).user.id,
                      user.id,
                    );
                if (context.mounted) {
                  await context.navigator.push(
                    MaterialPageRoute<void>(
                      builder: (context) => ChatScreen(user, chatId),
                    ),
                  );
                }
              },
            );
          },
        ),
        error: (error, stackTrace) => ErrorScreen(message: error.toString()),
        loading: () => const LoadingScreen(),
      ),
    );
  }
}
