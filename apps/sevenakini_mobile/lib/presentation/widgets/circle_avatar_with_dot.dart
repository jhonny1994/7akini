import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class CircleAvatarWithDot extends StatelessWidget {
  const CircleAvatarWithDot({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: context.colorScheme.primary,
          backgroundImage: CachedNetworkImageProvider(imageUrl),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
              border: Border.all(
                color: context.colorScheme.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
