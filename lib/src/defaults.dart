import 'package:ligdicash/src/types.dart';

const Map<PlatformType, String> confBaseUrl = {
  PlatformType.test: 'https://test.ligdicash.com/pay/v01/',
  PlatformType.live: 'https://app.ligdicash.com/pay/v01/',
};

/// Retourne l'URL de base de la plateforme en fonction de son nom.
///
/// L'URL de base correspondante, ou null si le nom de la plateforme est invalide.
///
/// Examples:
/// ```dart
/// getPlatformUrl(PlatformType.test); // 'https://test.ligdicash.com/pay/v01/'
/// getPlatformUrl(PlatformType.live); // 'https://app.ligdicash.com/pay/v01/'
/// ```
String? getPlatformUrl(PlatformType name) {
  return confBaseUrl[name];
}
