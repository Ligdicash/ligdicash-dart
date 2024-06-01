import 'package:ligdicash/src/errors.dart';
import 'package:ligdicash/src/types.dart';

import 'providers.dart';
import 'responses.dart';

/// Récupère une transaction à partir d'un jeton.
///
/// [token] Le jeton de la transaction.
/// [type] Le type de transaction, "payin" par défaut.
///
/// Returns Une instance de [StatusResponse] représentant la transaction.
///
/// Throws [InvalidTokenError] si le jeton est invalide ou non fourni.
Future<StatusResponse> getTransaction({
  required String apikey,
  required String authToken,
  required PlatformType platform,
  required String token,
  TransactionType type = TransactionType.payin,
}) async {
  if (token.isEmpty) {
    throw InvalidTokenError("invalidtoken");
  }

  HTTPProvider provider = HTTPProvider(
    apikey: apikey,
    authToken: authToken,
    platform: platform,
  );
  String endpoint = (type == TransactionType.payin)
      ? "redirect/checkout-invoice/confirm/?invoiceToken=$token"
      : "withdrawal/confirm/?withdrawalToken=$token";

  final response = await provider.get(endpoint, WikiType.status);

  return StatusResponse.fromJson(response);
}
