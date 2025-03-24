import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_template/src/core/api/api_service.dart';
import 'package:my_template/src/features/auth/data/sign_in_repository.dart';
import 'package:my_template/src/features/auth/domain/token.dart';

import '../../../../mocks.dart';

void main() {
  late MockApiService mockApiService;
  late SignInRepository signInRepository;

  setUp(() {
    mockApiService = MockApiService();
    signInRepository = SignInRepository(mockApiService);
  });

  test("retrieve sigInRepository with mock apiService", () {
    final container = createContainer(overrides: [
      apiServiceProvider.overrideWithValue(mockApiService),
    ]);
    final sigInRepositoryProvider = container.read(signInRepositoryProvider);
    expect(sigInRepositoryProvider, isA<SignInRepository>());
    expect(container.read(apiServiceProvider), mockApiService);
  });

  test("sigin in success", () async {
    final email = "test@gmail.com";
    final password = "123456";
    final data = {"email": email, "password": password};
    final token = Token(
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
        expiredAt: 'expiredAt');
    when(() => mockApiService.post(any(), data: data)).thenAnswer((_) async =>
        Response(
            requestOptions: RequestOptions(path: ''), data: token.toJson()));

    final realToken =
        await signInRepository.signIn(email: email, password: password);
    expect(realToken, token);
    verify(() => mockApiService.post(any(), data: data)).called(1);
  });

  test("sigin in failed", () async {
    when(() => mockApiService.post(any(), data: any(named: 'data'))).thenThrow(
      DioException(
        requestOptions: RequestOptions(),
      ),
    );

    expect(
      () async =>
          await signInRepository.signIn(email: 'email', password: 'password'),
      throwsA(
        isA<DioException>(),
      ),
    );
    verify(() => mockApiService.post(any(), data: any(named: 'data')))
        .called(1);
  });
}
