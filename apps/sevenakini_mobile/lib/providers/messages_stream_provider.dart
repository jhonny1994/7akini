import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_mobile/domain/message.dart';
import 'package:sevenakini_shared/features/auth/auth.dart';
import 'package:sevenakini_shared/features/core/core.dart';

final messagesStreamProvider = StreamProvider<List<Message>>((ref) async* {
  final supabase = ref.read(supabaseProvider);
  final myId = ref.read(authStateNotifierProvider.notifier).user.id;
  final messagesStream = supabase
      .from('messages')
      .stream(primaryKey: ['id'])
      .order('created_at')
      .map(
        (maps) => maps
            .map(
              (map) => Message.fromJson(map, myId),
            )
            .toList(),
      );
  yield* messagesStream;
});
