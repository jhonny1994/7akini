import 'package:flutter/material.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    required this.validator,
    this.suffixIcon,
  });
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String? Function(String?) validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colorScheme.primary.withOpacity(0.25),
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(kDefaultGap),
      ),
    );

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: defaultBorder,
        enabledBorder: defaultBorder,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
