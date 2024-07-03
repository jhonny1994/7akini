import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sevenakini_mobile/presentation/widgets/app_drawer.dart';
import 'package:sevenakini_mobile/presentation/widgets/users_list_view.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersStream = ref.watch(userStreamProvider);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('7akini'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Iconsax.menu_1),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: usersStream.when(
        data: (users) => users.isEmpty
            ? const EmptyScreen(message: 'Users list is empty')
            : UsersListView(users: users),
        error: (error, stackTrace) =>
            ErrorScreen(message: error.toString(), isSimple: true),
        loading: () => const LoadingScreen(isSimple: true),
      ),
    );
  }
}
