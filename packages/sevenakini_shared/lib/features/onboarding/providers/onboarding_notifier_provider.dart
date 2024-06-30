import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/features/core/providers/shared_prefrences_provider.dart';
import 'package:sevenakini_shared/features/onboarding/application/onboarding_notifier.dart';

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  return OnboardingNotifier(ref.read(sharedPreferencesProvider));
});
