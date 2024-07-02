import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 600;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isSmallScreen
              ? const SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthImage(
                        imagePath: 'assets/user-info.svg',
                        text: 'Please fill in your details',
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
                          imagePath: 'assets/user-info.svg',
                          text: 'Please fill in your details',
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
  final TextEditingController _nameController = TextEditingController();
  late Gender gender;

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
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
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
                  r'^[^\s]+( [^\s]+)+$',
                ).hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid name';
                }

                return null;
              },
              controller: _nameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Full name',
                hintText: 'Enter your name',
                prefixIcon: const Icon(Icons.person_outlined),
                border: defaultBorder,
                enabledBorder: defaultBorder,
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
                  padding:
                      isSmallScreen ? kDefaultPadding : kDefaultPadding * 2,
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await ref
                        .read(authStateNotifierProvider.notifier)
                        .addUserInfo(
                          fullName: _nameController.text,
                          username: _usernameController.text,
                          gender: gender,
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
