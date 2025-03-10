import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_template/src/core/api/api.dart';
import 'package:my_template/src/core/api/api_service.dart';
import 'package:my_template/src/features/auth/domain/token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_repository.g.dart';

@riverpod
SignInRepository signInRepository(Ref ref) {
  final apiService = ref.read(apiServiceProvider);
  return SignInRepository(apiService);
}

class SignInRepository {
  final ApiService _apiService;

  const SignInRepository(this._apiService);

  Future<Token> signIn({
    required String email,
    required String password,
  }) async {
    final resp = await _apiService
        .post(Api.signIn, data: {"email": email, "password": password});
    return Token.fromJson(resp.data);
  }
}
