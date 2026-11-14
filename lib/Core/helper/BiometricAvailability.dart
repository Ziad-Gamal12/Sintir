import 'package:local_auth/local_auth.dart';

class BiometricAvailability {
  static bool isAvailable = false;

  static Future<void> init() async {
    try {
      isAvailable = await LocalAuthentication().isDeviceSupported();
    } catch (_) {
      isAvailable = false;
    }
  }
}
