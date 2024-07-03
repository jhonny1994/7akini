import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class UserInfoScreen extends ConsumerWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AuthBaseScreen(
      imagePath: 'assets/user-info.svg',
      headerText: 'Please fill in your details',
      formContent: _UserInfoForm(),
    );
  }
}

class _UserInfoForm extends ConsumerStatefulWidget {
  const _UserInfoForm();

  @override
  ConsumerState<_UserInfoForm> createState() => __UserInfoFormState();
}

class __UserInfoFormState extends ConsumerState<_UserInfoForm> {
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthFormField(
            controller: _usernameController,
            labelText: 'Username',
            hintText: 'Enter your username',
            prefixIcon: Icons.person_outlined,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              final usernameValid =
                  RegExp(r'^[a-z0-9_-]{5,15}$').hasMatch(value);
              if (!usernameValid) {
                return 'Please enter a valid username';
              }
              return null;
            },
          ),
          Gap(isSmallScreen ? kDefaultGap : kDefaultGap * 2),
          AuthFormField(
            controller: _nameController,
            labelText: 'Full name',
            hintText: 'Enter your name',
            prefixIcon: Icons.person_outlined,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              final nameValid = RegExp(r'^[^\s]+( [^\s]+)+$').hasMatch(value);
              if (!nameValid) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          Gap(isSmallScreen ? kDefaultGap : kDefaultGap * 2),
          DropdownButtonFormField<Gender>(
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
          SubmitButton(
            text: 'Save',
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                await ref.read(authStateNotifierProvider.notifier).addUserInfo(
                      fullName: _nameController.text.trim(),
                      username: _usernameController.text.trim(),
                      gender: gender,
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
