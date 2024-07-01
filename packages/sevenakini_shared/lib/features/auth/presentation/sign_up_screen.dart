import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/features/auth/domain/user.dart';
import 'package:sevenakini_shared/features/auth/presentation/widgets/auth_image.dart';
import 'package:sevenakini_shared/features/auth/providers/auth_state_notifier_provider.dart';
import 'package:sevenakini_shared/features/core/utils/constants.dart';
import 'package:sevenakini_shared/features/core/utils/extensions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? const SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthImage(
                      imagePath: 'assets/sign-up.svg',
                    ),
                    Gap(kDefaultGap * 2),
                    _FormContent(),
                  ],
                ),
              )
            : Container(
                padding: kDefaultPadding * 2,
                child: const Row(
                  children: [
                    Expanded(
                      child: AuthImage(
                        imagePath: 'assets/sign-up.svg',
                      ),
                    ),
                    Gap(kDefaultGap * 2),
                    Expanded(
                      child: Center(child: _FormContent()),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _FormContent extends ConsumerStatefulWidget {
  const _FormContent();

  @override
  ConsumerState<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends ConsumerState<_FormContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Gender gender;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 600;
    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colorScheme.primary.withOpacity(0.25),
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(kDefaultGap),
      ),
    );
    return Container(
      padding: kDefaultPadding,
      constraints: BoxConstraints(
        maxWidth: isSmallScreen ? context.width : context.width * 0.5,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                final emailValid = RegExp(
                  r'^[a-z0-9_-]{5,15}$',
                ).hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid username';
                }

                return null;
              },
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                prefixIcon: const Icon(Icons.person_outlined),
                border: defaultBorder,
                enabledBorder: defaultBorder,
              ),
            ),
            Gap(isSmallScreen ? kDefaultGap : kDefaultGap * 2),
            TextFormField(
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
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email_outlined),
                border: defaultBorder,
                enabledBorder: defaultBorder,
              ),
            ),
            Gap(isSmallScreen ? kDefaultGap : kDefaultGap * 2),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                final passwordValid =
                    RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value);
                if (!passwordValid) {
                  return 'Password must be a mix ofletters and numbers.';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: defaultBorder,
                enabledBorder: defaultBorder,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            Gap(isSmallScreen ? kDefaultGap : kDefaultGap * 2),
            DropdownButtonFormField(
              items: Gender.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                border: defaultBorder,
                enabledBorder: defaultBorder,
                labelText: 'Gender',
                hintText: 'Choose your gender',
                prefixIcon: const Icon(Icons.person_pin_circle_outlined),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please choose a gender';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            Gap(isSmallScreen ? kDefaultGap : kDefaultGap * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kDefaultGap * 2),
                  ),
                ),
                child: Padding(
                  padding: kDefaultPadding * 2,
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await ref.read(authStateNotifierProvider.notifier).signUp(
                          _usernameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          gender,
                        );
                  }
                },
              ),
            ),
            Gap(isSmallScreen ? kDefaultGap / 2 : kDefaultGap),
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
      ),
    );
  }
}
