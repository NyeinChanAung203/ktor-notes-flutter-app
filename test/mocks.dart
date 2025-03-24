import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_template/src/core/api/api_service.dart';
import 'package:my_template/src/core/services/storage/storage_manager.dart';
import 'package:my_template/src/features/auth/data/sign_in_repository.dart';
import 'package:my_template/src/features/auth/service/auth_service.dart';

ProviderContainer createContainer(
    {ProviderContainer? parent,
    List<Override> overrides = const [],
    List<ProviderObserver>? observers}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);
  return container;
}

class MockApiService extends Mock implements ApiService {}

class MockSignInRepository extends Mock implements SignInRepository {}

class MockStorageManager extends Mock implements IStorageManager {}

class MockAuthService extends Mock implements AuthService {}
