import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.message,
    super.key,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            SizedBox(
              height: context.width - kDefaultPadding.horizontal,
              width: context.width - kDefaultPadding.horizontal,
              child: SvgPicture.asset('assets/error.svg'),
            ),
            const Spacer(),
            Text(message),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              child: const Text('Retry'),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
