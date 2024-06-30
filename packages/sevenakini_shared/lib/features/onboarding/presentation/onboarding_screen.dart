import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      PageData(
        image: 'assets/chat.svg',
        title: 'Messaging made easier',
        bgColor: context.colorScheme.primary,
        textColor: context.colorScheme.onPrimary,
      ),
      PageData(
        image: 'assets/chat.svg',
        title: 'All your friends in one place',
        bgColor: context.colorScheme.secondary,
        textColor: context.colorScheme.onSecondary,
      ),
      PageData(
        image: 'assets/chat.svg',
        title: 'Simple. Secure. Reliable.',
        bgColor: context.colorScheme.primary,
        textColor: context.colorScheme.onPrimary,
      ),
    ];

    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: context.width * 0.1,
        itemCount: pages.length,
        scaleFactor: 2,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Icon(
            Icons.navigate_next,
            size: context.width * 0.08,
          ),
        ),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
      ),
    );
  }
}

class PageData {
  const PageData({
    required this.title,
    required this.image,
    required this.bgColor,
    required this.textColor,
  });

  final Color bgColor;
  final String image;
  final Color textColor;
  final String title;
}

class _Page extends StatelessWidget {
  const _Page({required this.page});

  final PageData page;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: kDefaultPadding,
          margin: kDefaultPadding,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: page.textColor,
          ),
          child: SvgPicture.asset(
            page.image,
            height: context.height * 0.1,
            width: context.height * 0.1,
          ),
        ),
        Text(
          page.title,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
