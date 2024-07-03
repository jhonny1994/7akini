import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AuthBaseScreen(
      imagePath: 'assets/sign-up.svg',
      headerText: 'Sign up to 7akini!',
      formContent: _SignUpForm(),
    );
  }
}

class _SignUpForm extends ConsumerStatefulWidget {
  const _SignUpForm();

  @override
  ConsumerState<_SignUpForm> createState() => __SignUpFormState();
}

class __SignUpFormState extends ConsumerState<_SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthFormField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              final emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              ).hasMatch(value);
              if (!emailValid) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const Gap(kDefaultGap * 2),
          AuthFormField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: !_isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              final passwordValid =
                  RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value);
              if (!passwordValid) {
                return 'Password must be a mix of letters and numbers.';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          const Gap(kDefaultGap * 2),
          SubmitButton(
            text: 'Sign up',
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                await ref.read(authStateNotifierProvider.notifier).signUp(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
              }
            },
          ),
          const Gap(kDefaultGap * 2),
          Text.rich(
            TextSpan(
              text: 'Already have an account?  ',
              children: [
                TextSpan(
                  text: 'Sign in',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => ref
                        .read(authStateNotifierProvider.notifier)
                        .checkAndUpdateState(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
