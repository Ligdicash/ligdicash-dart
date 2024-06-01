import 'package:ligdicash/src/types.dart';

import 'providers.dart';
import 'responses.dart';

/// Classe représentant un retrait via l'API.
class Withdrawal extends HTTPProvider {
  /// Montant du retrait.
  double amount;

  /// Description optionnelle du retrait.
  String description;

  /// Numero de destinataire du retrait.
  String customer;

  /// Constructeur pour créer une instance de retrait.
  ///
  /// [apikey] La clé API nécessaire pour l'authentification.
  /// [authToken] Le jeton d'authentification.
  /// [platform] La plateforme sur laquelle le retrait est effectué.
  /// [amount] Le montant du retrait.
  /// [customer] L'identifiant du client.
  /// [description] Une description optionnelle du retrait.
  Withdrawal({
    required String apikey,
    required String authToken,
    required PlatformType platform,
    required this.amount,
    required this.customer,
    this.description = "",
  }) : super(
          apikey: apikey,
          authToken: authToken,
          platform: platform,
        ) {}

  /// Envoie la demande de retrait à l'API et retourne la réponse.
  ///
  /// [type] Le type de retrait, par défaut à client.
  /// [toWallet] True si le montant reste dans le portefeuille Ligdicash du client. False si le montant est envoyé sur le compte mobile money du client.
  /// [callbackUrl] URL de callback pour les notifications de traitement.
  /// [customData] Données personnalisées à inclure dans la requête.
  Future<BaseResponse> send({
    WithdrawalType type = WithdrawalType.client,
    bool toWallet = false,
    String callbackUrl = "",
    Map<String, dynamic> customData = const {},
  }) async {
    Map<String, dynamic> command = {
      "amount": amount,
      "description": description,
      "customer": customer,
      "custom_data": customData,
      "callback_url": callbackUrl,
    };

    if (type == WithdrawalType.client) {
      command["top_up_wallet"] = toWallet ? 1 : 0;
    }

    Map<String, dynamic> payload = {
      "commande": command,
    };

    WikiType feature = (type == WithdrawalType.client)
        ? WikiType.client_payout
        : WikiType.merchant_payout;

    final response = await this.post("withdrawal/create", payload, feature);
    final responseData = BaseResponse.fromJson(response);
    return responseData;
  }
}
