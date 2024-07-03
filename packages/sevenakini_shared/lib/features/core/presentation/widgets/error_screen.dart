import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/features/auth/providers/auth_state_notifier_provider.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({
    required this.message,
    super.key,
    this.isSimple = false,
  });

  final bool isSimple;
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kDefaultPadding,
          child: Center(
            child: isSimple
                ? Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge,
                  )
                : Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height:
                            context.width * 0.75 - kDefaultPadding.horizontal,
                        width:
                            context.width * 0.75 - kDefaultPadding.horizontal,
                        child: SvgPicture.asset('assets/error.svg'),
                      ),
                      const Gap(kDefaultGap),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () => ref
                            .read(authStateNotifierProvider.notifier)
                            .checkAndUpdateState(),
                        child: const Text('Retry'),
                      ),
                      const Gap(kDefaultGap),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
