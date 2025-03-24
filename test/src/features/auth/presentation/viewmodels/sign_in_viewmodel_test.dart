import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_template/src/core/exceptions/error_handler.dart';
import 'package:my_template/src/features/auth/presentation/viewmodels/sign_in_viewmodel.dart';
import 'package:my_template/src/features/auth/service/auth_service.dart';

import '../../../../../mocks.dart';

void main() {
  late SignInViewmodel viewModel;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    // Provide the mock AuthService to the viewmodel
    final container = createContainer(
      overrides: [
        authServiceProvider.overrideWithValue(mockAuthService),
      ],
    );
    viewModel = container.read(signInViewmodelProvider.notifier);
  });

  test('Initial state should be SignInInitial', () {
    expect(viewModel.state, isA<SignInInitial>());
  });

  test('SignIn should emit SignInLoading while signing in', () async {
    when(() => mockAuthService.signIn(
        email: 'test@example.com', password: 'password')).thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 100)); // Simulate delay
    });

    final future =
        viewModel.signIn(email: 'test@example.com', password: 'password');

    expect(viewModel.state, isA<SignInLoading>()); // Verify loading state

    await future; // Wait for completion
  });

  test('SignIn success and state must be SignInSuccess', () async {
    // Arrange
    when(() => mockAuthService.signIn(
            email: 'test@example.com', password: 'password'))
        .thenAnswer((_) async => {}); // Simulate a successful sign-in

    // Act
    await viewModel.signIn(email: 'test@example.com', password: 'password');

    // Assert
    expect(viewModel.state, isA<SignInSuccess>());
    verify(() => mockAuthService.signIn(
        email: 'test@example.com', password: 'password')).called(1);
  });

  test('SignIn failed and state must be SignInError with error message',
      () async {
    // Arrange
    final exception = Exception('Sign-in failed');
    when(() => mockAuthService.signIn(
            email: 'test@example.com', password: 'password'))
        .thenThrow(exception); // Simulate a failed sign-in

    // Act
    await viewModel.signIn(email: 'test@example.com', password: 'password');

    // Assert
    expect(viewModel.state, isA<SignInError>());
    expect((viewModel.state as SignInError).message,
        ErrorHandler.getMessage(exception));
    verify(() => mockAuthService.signIn(
        email: 'test@example.com', password: 'password')).called(1);
  });
}
