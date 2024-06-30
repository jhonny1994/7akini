import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

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
              child: SvgPicture.asset('assets/empty.svg'),
            ),
            const Spacer(),
            const Text('This chat is empty'),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
