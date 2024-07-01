import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authStateNotifierProvider.notifier).user;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              child: CachedNetworkImage(imageUrl: user.imageUrl!),
            ),
            Text(
              '@${user.username}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(flex: 2),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Iconsax.profile_circle),
              title: const Text('Profile'),
              onTap: () =>
                  ref.read(authStateNotifierProvider.notifier).signOut(),
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Iconsax.setting_2),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Iconsax.logout),
              title: const Text('Sign out'),
              onTap: () =>
                  ref.read(authStateNotifierProvider.notifier).signOut(),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
