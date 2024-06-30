import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_response.freezed.dart';

@freezed
class AppResponse with _$AppResponse {
  const factory AppResponse.success({String? message}) = _Success;

  const factory AppResponse.failure(String message) = _Failure;
}
