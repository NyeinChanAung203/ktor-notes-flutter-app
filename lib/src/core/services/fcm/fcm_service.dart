import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_template/src/core/api/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FcmService {
  final ApiService apiService;

  const FcmService(this.apiService);

  Future<void> sendFCMToken() async {
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    // FirebaseMessaging.instance.requestPermission()
    // await apiService.post(
    //   Api.deviceTokenUrl,
    //   data: {'token': fcmToken},
    // );
  }
}

@riverpod
FutureOr<void> sendFCMToken(Ref ref) {
  try {
    // return ref.read(fcmServiceProvider).sendFCMToken();
  } catch (e) {
    rethrow;
  }
}
