import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({
    required this.imagePath,
    super.key,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          imagePath,
          height: isSmallScreen ? 100 : 200,
          width: isSmallScreen ? 100 : 200,
        ),
        Padding(
          padding: kDefaultPadding,
          child: Text(
            'Welcome to 7akini!',
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.titleLarge
                : Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
