import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kDefaultPadding,
          child: Center(
            child: Column(
              children: [
                const Spacer(flex: 2),
                SizedBox(
                  height: context.width * 0.75 - kDefaultPadding.horizontal,
                  width: context.width * 0.75 - kDefaultPadding.horizontal,
                  child: SvgPicture.asset('assets/loading.svg'),
                ),
                const Spacer(),
                CircularProgressIndicator.adaptive(
                  backgroundColor: context.colorScheme.primary,
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
