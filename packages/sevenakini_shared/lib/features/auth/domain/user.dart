// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum Gender { male, female }

@freezed
class User with _$User {
  factory User({
    required String id,
    required String username,
    required String email,
    required Gender gender,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
