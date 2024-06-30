import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/features/core/providers/shared_prefrences_provider.dart';
import 'package:sevenakini_shared/features/theme/application/theme_state_notifier.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(ref.read(sharedPreferencesProvider)),
);
