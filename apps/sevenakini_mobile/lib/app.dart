import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_mobile/features/auth/presentation/auth_screen.dart';
import 'package:sevenakini_mobile/features/onboarding/presentation/onboarding_screen.dart';
import 'package:sevenakini_shared/features/core/utils/theme.dart';
import 'package:sevenakini_shared/features/onboarding/providers/onboarding_notifier_provider.dart';
import 'package:sevenakini_shared/features/theme/providers/theme_notifier_provider.dart';

class Sevenakini extends ConsumerWidget {
  const Sevenakini({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);
    final isBoarded = ref.watch(onboardingNotifierProvider);

    SystemChrome.setSystemUIOverlayStyle(
      !isDarkMode
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: isBoarded ? const AuthScreen() : const OnboardingScreen(),
    );
  }
}
