import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/features/onboarding/application/onboarding_notifier.dart';
import 'package:sevenakini_shared/features/theme/providers/shared_prefrences_provider.dart';

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  return OnboardingNotifier(ref.read(sharedPreferencesProvider));
});
