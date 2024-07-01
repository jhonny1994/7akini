// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    @JsonKey(includeToJson: false) String? id,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'receiver_id') required String receiverId,
    @JsonKey(name: 'chat_id') required String chatId,
    required String content,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
