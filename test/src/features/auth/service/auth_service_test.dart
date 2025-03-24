import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_template/src/core/services/storage/storage_manager.dart';
import 'package:my_template/src/features/auth/data/sign_in_repository.dart';
import 'package:my_template/src/features/auth/domain/token.dart';
import 'package:my_template/src/features/auth/service/auth_service.dart';

import '../../../../mocks.dart';

void main() {
  late MockSignInRepository mockSignInRepository;
  late MockStorageManager mockStorageManager;
  late MockApiService mockApiService;
  late AuthService authService;

  setUp(() {
    mockSignInRepository = MockSignInRepository();
    mockStorageManager = MockStorageManager();
    mockApiService = MockApiService();
    authService =
        AuthService(mockSignInRepository, mockStorageManager, mockApiService);
  });

  test("retrieve auth service with correct dependencies", () {
    final container = createContainer(overrides: [
      signInRepositoryProvider.overrideWithValue(mockSignInRepository),
      storageManagerProvider.overrideWithValue(mockStorageManager),
    ]);

    final authService = container.read(authServiceProvider);
    expect(authService, isA<AuthService>());
    expect(container.read(signInRepositoryProvider), mockSignInRepository);
    expect(container.read(storageManagerProvider), mockStorageManager);
  });

  test("auth service sign in success and saved token and set token to header",
      () async {
    final email = "email@gmail.com";
    final password = "password";
    final token = Token(
        accessToken: 'access',
        refreshToken: 'refreshToken',
        expiredAt: 'expiredAt');

    when(() => mockSignInRepository.signIn(email: email, password: password))
        .thenAnswer((_) async => token);

    when(() => mockStorageManager.saveToken(token))
        .thenAnswer((_) => Future.value());

    when(() => mockApiService.setAuthToken(token.accessToken)).thenReturn(null);

    await authService.signIn(email: email, password: password);

    verify(() => mockSignInRepository.signIn(email: email, password: password))
        .called(1);
    verify(() => mockStorageManager.saveToken(token)).called(1);
    verify(() => mockApiService.setAuthToken(token.accessToken)).called(1);
  });

  test(
      "auth service sign in failed and did not save token and did not set auth header",
      () async {
    final email = "email@gmail.com";
    final password = "password";
    final token = Token(
        accessToken: 'access',
        refreshToken: 'refreshToken',
        expiredAt: 'expiredAt');

    when(() => mockSignInRepository.signIn(email: email, password: password))
        .thenThrow(DioException(requestOptions: RequestOptions()));

    when(() => mockStorageManager.saveToken(token))
        .thenAnswer((_) => Future.value());

    when(() => mockApiService.setAuthToken(token.accessToken)).thenReturn(null);

    expect(
        () async => await authService.signIn(email: email, password: password),
        throwsA(isA<DioException>()));

    verify(() => mockSignInRepository.signIn(email: email, password: password))
        .called(1);
    verifyNever(() => mockStorageManager.saveToken(token));
    verifyNever(() => mockApiService.setAuthToken(token.accessToken));
  });
}
