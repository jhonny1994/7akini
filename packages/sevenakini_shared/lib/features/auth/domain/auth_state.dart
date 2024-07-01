import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.loading() = Loading;
  const factory AuthState.error({required String message}) = Error;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated({@Default(true) bool? isSignIn}) =
      Unauthenticated;
}
