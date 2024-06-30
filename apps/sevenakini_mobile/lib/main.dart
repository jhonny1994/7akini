import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sevenakini_mobile/features/app.dart';

void main() async {
  final appDir = await getApplicationDocumentsDirectory();

  runApp(
    ProviderScope(
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
