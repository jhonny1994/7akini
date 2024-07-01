import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';
import 'package:sevenakini_shared/features/onboarding/providers/onboarding_notifier_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      const PageData(
        image: 'assets/chat.svg',
        title: 'Messaging made easier',
        desc:
            'Experience seamless and efficient messaging with our user-friendly interface.',
      ),
      const PageData(
        image: 'assets/connect.svg',
        title: 'All your friends in one place',
        desc:
            'Stay connected with all your friends, family, and colleagues in one convenient app.',
      ),
      const PageData(
        image: 'assets/safe.svg',
        title: 'Simple. Secure. Reliable.',
        desc:
            'Enjoy peace of mind with our secure and reliable messaging platform.',
      ),
    ];

    return Scaffold(
      body: ConcentricPageView(
        colors: [
          context.colorScheme.primary,
          context.colorScheme.secondary,
          context.colorScheme.tertiary,
        ],
        // itemCount: pages.length,
        nextButtonBuilder: (context) => Icon(
          Icons.navigate_next,
          size: context.width * 0.1,
          color: context.colorScheme.surface,
        ),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
        itemCount: pages.length,
        onFinish: () => ref.read(onboardingNotifierProvider.notifier).toggle(),
      ),
    );
  }
}

class PageData {
  const PageData({
    required this.title,
    required this.desc,
    required this.image,
  });

  final String image;
  final String title;
  final String desc;
}

class _Page extends StatelessWidget {
  const _Page({required this.page});

  final PageData page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kDefaultPadding,
      child: Column(
        children: [
          const Spacer(),
          ClipOval(
            child: Container(
              color: context.colorScheme.surface,
              constraints: BoxConstraints(
                maxHeight: context.width * 0.75,
                maxWidth: context.width * 0.75,
              ),
              padding: EdgeInsets.all(context.width * 0.1),
              child: SvgPicture.asset(page.image),
            ),
          ),
          const Gap(kDefaultGap * 2),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(kDefaultGap),
          Text(
            page.desc,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
