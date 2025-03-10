import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_template/src/core/api/api_service.dart';
import 'package:my_template/src/core/services/storage/storage_manager.dart';
import 'package:my_template/src/features/auth/data/sign_in_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService(
    ref.read(signInRepositoryProvider),
    ref.read(storageManagerProvider),
    ref.read(apiServiceProvider),
  );
}

class AuthService {
  final SignInRepository _signInRepository;
  final IStorageManager _iStorageManager;
  final ApiService _apiService;

  const AuthService(
      this._signInRepository, this._iStorageManager, this._apiService);

  Future<void> signIn({required String email, required String password}) async {
    final token =
        await _signInRepository.signIn(email: email, password: password);
    await _iStorageManager.saveToken(token);
    _apiService.setAuthToken(token.accessToken);
  }
}
