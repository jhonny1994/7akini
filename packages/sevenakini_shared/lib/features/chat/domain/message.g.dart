// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String?,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      chatId: json['chat_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'chat_id': instance.chatId,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
    };
