import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthHelper {
  BiometricAuthHelper._();

  static final LocalAuthentication _localAuthentication = LocalAuthentication();

  static Future<bool> isAvailable() async {
    try {
      final canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
      final isDeviceSupported = await _localAuthentication.isDeviceSupported();
      final availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();

      return (canCheckBiometrics || isDeviceSupported) &&
          availableBiometrics.isNotEmpty;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> authenticate({required String reason}) async {
    try {
      return await _localAuthentication.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}
