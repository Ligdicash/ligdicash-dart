import 'package:ligdicash/src/types.dart';

class BaseResponse {
  /// Code de réponse de la requête, "00" ou "01".
  final String responseCode;

  /// Token de la requête.
  final String token;

  /// Texte de réponse de la requête.
  final String responseText;

  /// Description de la réponse.
  final String description;

  /// Lien documentant les codes d'erreurs
  final String wiki;

  /// Données personnalisées de la réponse.
  final Map<String, dynamic> customData;

  BaseResponse({
    required this.responseCode,
    required this.token,
    required this.responseText,
    required this.description,
    required this.wiki,
    Map<String, dynamic> customData = const {},
  }) : customData = customData;

  /// Crée une instance de [BaseResponse] à partir d'un JSON.
  ///
  /// [json] Le JSON contenant les données de la réponse.
  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      responseCode: json['response_code'],
      token: json['token'],
      responseText: json['response_text'],
      description: json['description'],
      wiki: json['wiki'],
      customData: Map<String, dynamic>.from(json['custom_data'] ?? {}),
    );
  }
}

class StatusResponse extends BaseResponse {
  /// Montant de la transaction.
  final int montant;

  /// Montant de la transaction.
  final int amount;

  /// Statut de la transaction.
  final TransactionStatus status;

  /// ID de l'opérateur de la transaction.
  final String operatorId;

  /// Nom de l'opérateur de la transaction.
  final String operatorName;

  /// ID externe de la transaction.
  final String? externalId;

  /// ID de la transaction.
  final String? transactionId;

  /// Date de la transaction.
  final String? date;

  /// Numéro utilisé pour la transaction.
  final String? customer;

  /// ID de la demande.
  final String? requestId;

  StatusResponse({
    required String responseCode,
    required String token,
    required String responseText,
    required String description,
    required String wiki,
    Map<String, dynamic> customData = const {},
    required String status,
    required this.montant,
    required this.amount,
    required this.operatorId,
    required this.operatorName,
    this.externalId,
    this.transactionId,
    this.date,
    this.customer,
    this.requestId,
  })  : status = status == 'pending'
            ? TransactionStatus.pending
            : status == 'completed'
                ? TransactionStatus.completed
                : TransactionStatus.nocompleted,
        super(
          responseCode: responseCode,
          token: token,
          responseText: responseText,
          description: description,
          wiki: wiki,
          customData: customData,
        );

  /// Crée une instance de [StatusResponse] à partir d'un objet JSON.
  ///
  /// [json] Le Map contenant les données JSON de la réponse.
  ///
  /// Retourne une nouvelle instance de [StatusResponse] peuplée avec les données du JSON.
  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    final customDataList = json['custom_data'] as List<dynamic>?;
    final customData = Map<String, String>.fromEntries(
      customDataList?.map((item) => MapEntry(
                item['keyof_customdata'] as String,
                item['valueof_customdata'] as String,
              )) ??
          const [],
    );
    return StatusResponse(
      responseCode: json['response_code'],
      token: json['token'],
      responseText: json['response_text'],
      description: json['description'],
      wiki: json['wiki'],
      customData: customData,
      status: json['status'],
      amount: int.parse(json['amount']),
      montant: int.parse(json['montant']),
      operatorId: json['operator_id'],
      operatorName: json['operator_name'],
      externalId: json['external_id'],
      transactionId: json['transaction_id'],
      date: json['date'],
      customer: json['customer'],
      requestId: json['request_id'],
    );
  }
}
