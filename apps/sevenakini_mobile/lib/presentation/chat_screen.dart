import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sevenakini_mobile/presentation/widgets/message_bubble.dart';
import 'package:sevenakini_mobile/providers/chat_notifier_provider.dart';
import 'package:sevenakini_mobile/providers/messages_stream_provider.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen(this.user, this.chatId, {super.key});
  final User user;
  final String chatId;
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final messagesStream = ref.watch(messagesStreamProvider(widget.chatId));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        titleTextStyle: context.textTheme.titleSmall,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_3,
            color: context.colorScheme.primary,
          ),
          onPressed: () => context.navigator.pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                widget.user.imageUrl!,
              ),
            ),
            const Gap(kDefaultGap),
            Text(widget.user.username),
          ],
        ),
      ),
      body: SafeArea(
        child: messagesStream.when(
          data: (messages) => Padding(
            padding: kDefaultPadding,
            child: Stack(
              children: [
                if (messages.isEmpty)
                  const EmptyScreen()
                else
                  ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages.elementAt(index);
                      return MessageBubble(
                        message: message,
                        user: widget.user,
                      );
                    },
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) => setState(() {}),
                          controller: contentController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: contentController.text.isEmpty
                            ? null
                            : () => ref.read(chatNotifierProvider).sendMessage(
                                  ref
                                      .read(authStateNotifierProvider.notifier)
                                      .user
                                      .id,
                                  widget.user.id,
                                  contentController.text.trim(),
                                  widget.chatId,
                                ),
                        icon: Icon(
                          Iconsax.send_1,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          error: (error, stackTrace) => ErrorScreen(message: error.toString()),
          loading: () => const LoadingScreen(),
        ),
      ),
    );
  }
}
