import 'package:flutter/material.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 600;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultGap * 2),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: isSmallScreen ? kDefaultPadding : kDefaultPadding * 2,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
