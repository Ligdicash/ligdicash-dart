import 'package:ligdicash/src/types.dart';

import 'providers.dart';
import 'responses.dart';

/// Représente un article dans une facture.
class InvoiceItem {
  /// Le nom de l'article.
  final String name;

  /// La description de l'article.
  final String description;

  /// La quantité de l'article.
  int quantity;

  /// Le prix unitaire de l'article.
  double unitPrice;

  /// Le prix total de l'article, calculé comme le produit de `unitPrice` et `quantity`.
  late double totalPrice;

  /// Crée une instance de `InvoiceItem` avec les détails nécessaires.
  ///
  /// [name] Le nom de l'article.
  /// [description] La description de l'article.
  /// [quantity] La quantité de l'article.
  /// [unitPrice] Le prix unitaire de l'article.
  InvoiceItem(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.unitPrice}) {
    totalPrice = unitPrice * quantity;
  }

  /// Retourne la quantité de l'article.
  int getQuantity() => quantity;

  /// Retourne le prix unitaire de l'article.
  double getUnitPrice() => unitPrice;

  /// Définit la quantité de l'article et met à jour le prix total.
  ///
  /// [newQuantity] La nouvelle quantité de l'article.
  setQuantity(int newQuantity) {
    quantity = newQuantity;
    totalPrice = unitPrice * newQuantity;
  }

  /// Définit le prix unitaire de l'article et met à jour le prix total.
  ///
  /// [newUnitPrice] Le nouveau prix unitaire de l'article.
  setUnitPrice(double newUnitPrice) {
    unitPrice = newUnitPrice;
    totalPrice = newUnitPrice * quantity;
  }

  /// Retourne une représentation sous forme de dictionnaire de l'article.
  ///
  /// Utilisé pour la sérialisation en JSON ou pour d'autres formes de stockage de données.
  Map<String, dynamic> toDict() => {
        'name': name,
        'description': description,
        'quantity': quantity,
        'unit_price': unitPrice,
        'total_price': totalPrice,
      };
}

/// Classe représentant une facture pour les paiements.
///
/// Cette classe gère la création et la manipulation des factures pour les paiements
/// en utilisant les méthodes fournies par `HTTPProvider`.
class Invoice extends HTTPProvider {
  late List<InvoiceItem> _items;
  String currency = "xof";
  String description = "";
  String customerFirstname = "";
  String customerLastname = "";
  String customerEmail = "";
  String storeName = "";
  String storeWebsiteUrl = "";
  String externalId = "";
  String otp = "";
  double _totalAmount = 0;

  /// Constructeur pour créer une instance de `Invoice`.
  ///
  /// Initialise une nouvelle facture avec les détails nécessaires et configure
  /// le fournisseur HTTP avec les clés API et les jetons d'authentification.
  Invoice({
    required String apikey,
    required String authToken,
    required PlatformType platform,
    this.currency = "xof",
    this.description = "",
    this.customerFirstname = "",
    this.customerLastname = "",
    this.customerEmail = "",
    this.storeName = "",
    this.storeWebsiteUrl = "",
  }) : super(apikey: apikey, authToken: authToken, platform: platform) {
    _items = [];
  }

  /// Obtient la liste des articles de la facture.
  List<InvoiceItem> get items => _items;

  /// Obtient le montant total de la facture.
  double get totalAmount => _totalAmount;

  /// Calcule le montant total de la facture en additionnant les prix totaux de tous les articles.
  void setItemsTotalAmount() {
    _totalAmount = _items.fold(0, (acc, item) => acc + item.totalPrice);
  }

  /// Ajoute un article à la facture et met à jour le montant total.
  ///
  /// [name] Le nom de l'article.
  /// [description] La description de l'article (facultatif).
  /// [quantity] La quantité de l'article.
  /// [unitPrice] Le prix unitaire de l'article.
  void addItem({
    required String name,
    String description = "",
    required int quantity,
    required double unitPrice,
  }) {
    _items.add(InvoiceItem(
        name: name,
        description: description,
        quantity: quantity,
        unitPrice: unitPrice));
    setItemsTotalAmount();
  }

  /// Formate la facture pour la sérialisation ou l'envoi via des requêtes HTTP.
  ///
  /// [customer] Le nom du client (facultatif).
  Map<String, dynamic> formatInvoice([String customer = ""]) {
    return {
      'items': _items.map((item) => item.toDict()).toList(),
      'total_amount': _totalAmount,
      'devise': currency,
      'description': description,
      'customer': customer,
      'customer_firstname': customerFirstname,
      'customer_lastname': customerLastname,
      'customer_email': customerEmail,
      'external_id': externalId,
      'otp': otp,
    };
  }

  /// Prépare le payload pour les requêtes de paiement avec ou sans redirection.
  ///
  /// [customer] Le nom du client (facultatif).
  /// [cancelUrl] URL de redirection en cas d'annulation (facultatif).
  /// [returnUrl] URL de redirection après paiement (facultatif).
  /// [callbackUrl] URL de callback pour le traitement post-paiement.
  /// [customData] Données personnalisées à inclure dans la requête (facultatif).
  Map<String, dynamic> formatPayload({
    String customer = "",
    String? cancelUrl,
    String? returnUrl,
    required String callbackUrl,
    Map<String, dynamic> customData = const {},
  }) {
    Map<String, dynamic> actions = {
      'callback_url': callbackUrl,
    };
    if (cancelUrl != null) {
      actions['cancel_url'] = cancelUrl;
    }
    if (returnUrl != null) {
      actions['return_url'] = returnUrl;
    }
    return {
      'commande': {
        'invoice': this.formatInvoice(customer),
        'store': {
          'name': storeName,
          'website_url': storeWebsiteUrl,
        },
        'actions': actions,
        'custom_data': customData,
      },
    };
  }

  /// Effectue un paiement avec redirection.
  ///
  /// [cancelUrl] URL de redirection en cas d'annulation (facultatif).
  /// [returnUrl] URL de redirection après paiement (facultatif).
  /// [callbackUrl] URL de callback pour le traitement post-paiement.
  /// [customData] Données personnalisées à inclure dans la requête (facultatif).
  Future<BaseResponse> payWithRedirection({
    String cancelUrl = "",
    String returnUrl = "",
    String callbackUrl = "",
    Map<String, dynamic> customData = const {},
  }) async {
    final payload = this.formatPayload(
      callbackUrl: callbackUrl,
      cancelUrl: cancelUrl,
      returnUrl: returnUrl,
      customData: customData,
    );
    final response = await this.post(
      "redirect/checkout-invoice/create",
      payload,
      WikiType.payin,
    );
    final responseData = BaseResponse.fromJson(response);
    return responseData;
  }

  /// Effectue un paiement sans redirection.
  ///
  /// [otp] Le code OTP pour la vérification (facultatif).
  /// [customer] Le nom du client.
  /// [callbackUrl] URL de callback pour le traitement post-paiement (facultatif).
  /// [customData] Données personnalisées à inclure dans la requête (facultatif).
  Future<BaseResponse> payWithoutRedirection({
    String otp = "",
    required String customer,
    String? callbackUrl,
    Map<String, dynamic> customData = const {},
  }) async {
    this.otp = otp;
    final payload = this.formatPayload(
      customer: customer,
      callbackUrl: callbackUrl ?? "",
      customData: customData,
    );
    final response = await this
        .post("straight/checkout-invoice/create", payload, WikiType.payin);
    final responseData = BaseResponse.fromJson(response);
    return responseData;
  }
}
