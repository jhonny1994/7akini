import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class AuthBaseScreen extends StatelessWidget {
  const AuthBaseScreen({
    super.key,
    required this.imagePath,
    required this.headerText,
    required this.formContent,
  });
  final String imagePath;
  final String headerText;
  final Widget formContent;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 600;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isSmallScreen
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthImage(
                        imagePath: imagePath,
                        text: headerText,
                      ),
                      const Gap(kDefaultGap * 2),
                      formContent,
                    ],
                  ),
                )
              : Container(
                  padding: kDefaultPadding * 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: AuthImage(
                          imagePath: imagePath,
                          text: headerText,
                        ),
                      ),
                      const Gap(kDefaultGap * 2),
                      Expanded(
                        child: Center(child: formContent),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
