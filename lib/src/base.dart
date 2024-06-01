import 'package:ligdicash/src/defaults.dart';
import 'package:ligdicash/src/responses.dart';
import 'package:ligdicash/src/transaction.dart' as transaction;
import 'package:ligdicash/src/payin.dart' as payin;
import 'package:ligdicash/src/payout.dart' as payout;
import 'package:ligdicash/src/types.dart';

/// Classe principale pour interagir avec l'API de Ligdicash.
class Ligdicash {
  /// La clé API pour l'authentification.
  final String apikey;

  /// Le jeton d'authentification pour l'API.
  final String authToken;

  /// La plateforme utilisée pour envoyer des requêtes HTTP.
  final PlatformType platform;

  /// L'URL de base de l'API.
  final String baseUrl;

  /// Crée une instance de [Ligdicash] avec les paramètres spécifiés.
  ///
  /// [apikey] La clé API nécessaire pour l'authentification.
  /// [authToken] Le jeton d'authentification.
  /// [platform] La plateforme sur laquelle les requêtes sont effectuées.
  /// [baseUrl] L'URL de base de l'API.
  ///
  /// Returns Une instance de [Ligdicash].
  Ligdicash(
      {required this.apikey,
      required this.authToken,
      required this.platform,
      String? baseUrl})
      : baseUrl = baseUrl ?? getPlatformUrl(platform) ?? '';

  /// Crée une instance de [Withdrawal] pour effectuer une demande de retrait d'argent.
  ///
  /// [amount] Le montant du retrait.
  /// [description] La description du retrait.
  /// [customer] L'identifiant du client.
  ///
  /// Returns Une instance de [Withdrawal].
  payout.Withdrawal Withdrawal({
    required double amount,
    required String description,
    required String customer,
  }) {
    return payout.Withdrawal(
      apikey: this.apikey,
      authToken: this.authToken,
      platform: this.platform,
      amount: amount,
      customer: customer,
      description: description,
    );
  }

  /// Crée une instance de [Invoice] pour générer une facture.
  ///
  /// [currency] La devise de la facture.
  /// [description] La description de la facture.
  /// [customerFirstname] Le prénom du client.
  /// [customerLastname] Le nom du client.
  /// [customerEmail] L'adresse e-mail du client.
  /// [storeName] Le nom du magasin.
  /// [storeWebsiteUrl] L'URL du site Web du magasin.
  ///
  /// Returns Une instance de [Invoice]
  payin.Invoice Invoice({
    required String currency,
    required String description,
    required String customerFirstname,
    required String customerLastname,
    required String customerEmail,
    required String storeName,
    required String storeWebsiteUrl,
  }) {
    return payin.Invoice(
      apikey: apikey,
      authToken: authToken,
      platform: platform,
      currency: currency,
      description: description,
      customerFirstname: customerFirstname,
      customerLastname: customerLastname,
      customerEmail: customerEmail,
      storeName: storeName,
      storeWebsiteUrl: storeWebsiteUrl,
    );
  }

  /// Récupère une transaction à partir d'un jeton.
  ///
  /// [token] Le jeton de la transaction.
  /// [type] Le type de transaction, "payin" par défaut.
  ///
  /// Returns Une instance de [StatusResponse] représentant la transaction.
  Future<StatusResponse> getTransaction(
      {required String token, TransactionType type = TransactionType.payin}) {
    return transaction.getTransaction(
      apikey: this.apikey,
      authToken: this.authToken,
      platform: this.platform,
      token: token,
      type: type,
    );
  }
}
