import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_mobile/presentation/chat_screen.dart';
import 'package:sevenakini_mobile/presentation/widgets/circle_avatar_with_dot.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class UsersListView extends ConsumerWidget {
  const UsersListView({
    super.key,
    required this.users,
  });
  final List<User> users;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users.elementAt(index);
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding.horizontal,
          ),
          leading: CircleAvatarWithDot(imageUrl: user.imageUrl!),
          title: Text(user.fullName),
          onTap: () async {
            final chatId = await ref.read(chatNotifierProvider).getChatId(
                  ref.read(userProvider).id,
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
    );
  }
}
