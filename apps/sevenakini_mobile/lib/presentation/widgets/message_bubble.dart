import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.user,
    super.key,
  });

  final Message message;
  final User user;

  @override
  Widget build(BuildContext context) {
    var chatContents = <Widget>[
      CircleAvatar(
        backgroundColor: context.colorScheme.primary,
        child: message.senderId != user.id
            ? CachedNetworkImage(imageUrl: user.imageUrl!)
            : Text(user.username.substring(0, 2)),
      ),
      const Gap(kDefaultGap),
      Flexible(
        child: Container(
          padding: kDefaultPadding,
          decoration: BoxDecoration(
            color: message.senderId == user.id
                ? context.colorScheme.primary
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.content),
        ),
      ),
      const Gap(kDefaultGap),
      Text(
        timeago.format(message.createdAt, locale: 'en_short'),
        style: context.textTheme.bodySmall,
      ),
    ];
    if (message.senderId != user.id) {
      chatContents = chatContents.reversed.toList();
    }
    return Row(
      mainAxisAlignment: message.senderId != user.id
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: chatContents,
    );
  }
}
