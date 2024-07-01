import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String userId,
    required String content,
    required DateTime createdAt,
    required bool isMine,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json, String myId) {
    final isMine = myId == json['user_id'];
    return Message(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isMine: isMine,
    );
  }
}
