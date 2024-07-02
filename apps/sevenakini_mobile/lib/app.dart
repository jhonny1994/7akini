import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_mobile/presentation/home_screen.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class Sevenakini extends ConsumerWidget {
  const Sevenakini({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);
    final isBoarded = ref.watch(onboardingNotifierProvider);
    final auth = ref.watch(authStateNotifierProvider);
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: isBoarded
          ? auth.when(
              loading: () => const LoadingScreen(),
              authenticated: () => const HomeScreen(),
              unauthenticated: (isSignIn) =>
                  isSignIn! ? const SignInScreen() : const SignUpScreen(),
              error: (String message) => ErrorScreen(message: message),
              userInfo: () => const UserInfoScreen(),
            )
          : const OnboardingScreen(),
    );
  }
}
