import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({
    required this.imagePath,
    required this.text,
    super.key,
  });
  final String imagePath;
  final String text;
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: isSmallScreen
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.headlineLarge,
        ),
        const Gap(kDefaultGap * 2),
        Container(
          constraints: BoxConstraints(
            maxHeight: context.width * 0.5,
            maxWidth: context.width * 0.5,
          ),
          child: SvgPicture.asset(imagePath),
        ),
      ],
    );
  }
}
