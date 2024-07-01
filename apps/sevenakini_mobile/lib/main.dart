import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sevenakini_mobile/app.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    debug: false,
  );

  final supabaseClient = Supabase.instance.client;
  final sharedPreferences = await SharedPreferences.getInstance();
  final appDir = await getApplicationDocumentsDirectory();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        supabaseProvider.overrideWithValue(supabaseClient),
      ],
      child: DevicePreview(
        enabled: Platform.isWindows,
        tools: [
          ...DevicePreview.defaultTools,
          DevicePreviewScreenshot(
            onScreenshot: screenshotAsFiles(appDir),
          ),
        ],
        builder: (context) => const Sevenakini(),
      ),
    ),
  );
}
