import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sevenakini_mobile/presentation/widgets/circle_avatar_with_dot.dart';
import 'package:sevenakini_mobile/presentation/widgets/message_bubble.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen(this.user, this.chatId, {super.key});

  final String chatId;
  final User user;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final contentController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

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
            CircleAvatarWithDot(imageUrl: widget.user.imageUrl!),
            const Gap(kDefaultGap),
            Text(widget.user.username),
          ],
        ),
      ),
      body: SafeArea(
        child: messagesStream.when(
          data: (messages) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              MediaQuery.of(context).viewInsets.bottom;
              scrollToBottom();
            });
            return Padding(
              padding: EdgeInsets.only(
                bottom: kDefaultPadding.bottom,
                left: kDefaultPadding.left,
                right: kDefaultPadding.right,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (messages.isEmpty)
                    const EmptyScreen(message: 'This chat is empty')
                  else
                    ListView.separated(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages.elementAt(index);
                        return MessageBubble(
                          message: message,
                          user: widget.user,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Gap(kDefaultGap),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ColoredBox(
                      color: context.colorScheme.surface,
                      child: Form(
                        key: formkey,
                        child: TextFormField(
                          controller: contentController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            return null;
                          },
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            suffixIcon: InkWell(
                              onTap: () async {
                                if (formkey.currentState?.validate() ?? false) {
                                  await ref
                                      .read(chatNotifierProvider)
                                      .sendMessage(
                                        ref
                                            .read(
                                              authStateNotifierProvider
                                                  .notifier,
                                            )
                                            .user
                                            .id,
                                        widget.user.id,
                                        contentController.text.trim(),
                                        widget.chatId,
                                      )
                                      .whenComplete(contentController.clear);
                                }
                              },
                              child: const Icon(Iconsax.send_1),
                            ),
                            fillColor:
                                context.colorScheme.onSurface.withOpacity(0.05),
                            filled: true,
                            hintText: 'Type a message...',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => ErrorScreen(message: error.toString()),
          loading: () => const LoadingScreen(),
        ),
      ),
    );
  }
}
