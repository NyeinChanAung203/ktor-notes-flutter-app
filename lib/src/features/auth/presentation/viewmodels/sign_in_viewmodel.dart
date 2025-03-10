import 'package:my_template/src/core/exceptions/error_handler.dart';
import 'package:my_template/src/features/auth/service/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_viewmodel.g.dart';

@riverpod
class SignInViewmodel extends _$SignInViewmodel {
  late final AuthService _authService;
  @override
  SignInUIState build() {
    _authService = ref.read(authServiceProvider);
    return SignInUIState.initial();
  }

  Future<void> signIn({
    required String email,
    required String password,
    // required void Function(String message) onError,
    // required void Function(Token token) onSuccess,
  }) async {
    state = SignInUIState.loading();
    final data = await AsyncValue.guard(
        () => _authService.signIn(email: email, password: password));
    if (data.hasError) {
      state = SignInUIState.error(ErrorHandler.getMessage(data.error));
    } else {
      state = SignInUIState.success();
    }
  }
}

sealed class SignInUIState {
  const SignInUIState();
  factory SignInUIState.initial() => SignInInitial();
  factory SignInUIState.loading() => SignInLoading();
  factory SignInUIState.error(String message) => SignInError(message);
  factory SignInUIState.success() => SignInSuccess();
}

class SignInInitial extends SignInUIState {}

class SignInLoading extends SignInUIState {}

class SignInError extends SignInUIState {
  final String message;
  const SignInError(this.message);
}

class SignInSuccess extends SignInUIState {}
