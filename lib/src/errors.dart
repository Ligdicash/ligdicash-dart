/// Classe de base pour les erreurs liées à l'API Ligdicash.
class LigdicashError implements Exception {
  /// Le code d'erreur associé à l'exception.
  final String code;

  /// Le message d'erreur associé à l'exception.
  final String message;

  /// Constructeur de la classe [LigdicashError].
  ///
  /// [code] : Le code d'erreur associé à l'exception.
  /// [message] : Le message d'erreur associé à l'exception.
  LigdicashError(this.code, this.message);

  @override
  String toString() => 'Code $code: $message';
}

/// Classe d'erreur pour les erreurs d'authentification Ligdicash.
class AuthenticationError extends LigdicashError {
  /// Initialise une nouvelle instance de [AuthenticationError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  AuthenticationError(String code)
      : super(code, 'api_key or auth_token is invalid');
}

/// Classe d'erreur pour les erreurs d'authentification d'application Ligdicash.
class ApplicationAuthenticationError extends LigdicashError {
  /// Initialise une nouvelle instance de [ApplicationAuthenticationError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  ApplicationAuthenticationError(String code)
      : super(code, 'Unable to authenticate your application');
}

/// Classe d'erreur si le solde du commerçant est insuffisant.
class MerchantBalanceLowError extends LigdicashError {
  /// Initialise une nouvelle instance de [MerchantBalanceLowError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  MerchantBalanceLowError(String code) : super(code, 'Merchant balance low');
}

/// Classe d'erreur si le retrait est désactivé pour ce commerçant.
class MerchantPayoutDisabledError extends LigdicashError {
  /// Initialise une nouvelle instance de [MerchantPayoutDisabledError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  MerchantPayoutDisabledError(String code)
      : super(code, 'Payout is disabled for this Merchant');
}

/// Classe d'erreur si la fonctionnalité de paiement n'est pas activée pour ce commerçant.
class MerchantPayinDisabledError extends LigdicashError {
  /// Initialise une nouvelle instance de [MerchantPayinDisabledError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  MerchantPayinDisabledError(String code)
      : super(code, 'Merchant Payin feature is not activated');
}

/// Classe d'erreur si le client n'est pas enregistré sur la plateforme.
class CustomerDoesNotExistError extends LigdicashError {
  /// Initialise une nouvelle instance de [CustomerDoesNotExistError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  CustomerDoesNotExistError(String code)
      : super(code, 'This customer is not registered on the platform');
}

/// Classe d'erreur si la transaction existe déjà.
class TransactionAlreadyExistError extends LigdicashError {
  /// Initialise une nouvelle instance de [TransactionAlreadyExistError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  TransactionAlreadyExistError(String code)
      : super(code, 'Transaction already exists');
}

/// Classe d'erreur si la facture n'a pas été trouvée.
class InvoiceNotFoundError extends LigdicashError {
  /// Initialise une nouvelle instance de [InvoiceNotFoundError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  InvoiceNotFoundError(String code) : super(code, 'Invoice not found');
}

/// Classe d'erreur si le montant est invalide. Il doit être compris entre 20 et 1 000 000.
class InvalidAmountError extends LigdicashError {
  /// Initialise une nouvelle instance de [InvalidAmountError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  InvalidAmountError(String code)
      : super(code,
            'Invalid amount. It should fall within the range of 20 to 1000000.');
}

/// Classe d'erreur si le Token est invalide.
class InvalidTokenError extends LigdicashError {
  /// Initialise une nouvelle instance de [InvalidTokenError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  InvalidTokenError(String code) : super(code, 'Invalid token');
}

/// Classe d'erreur si aucun compte marchand sur le réseau spécifié.
class MerchantAccountDoesNotExistError extends LigdicashError {
  /// Initialise une nouvelle instance de [MerchantAccountDoesNotExistError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  MerchantAccountDoesNotExistError(String code)
      : super(code, 'No merchant account on the specified network');
}

/// Classe d'erreur si aucun paiement en attente ou traité au cours des dernières 24 heures.
class NoPendProcPayout24HError extends LigdicashError {
  /// Initialise une nouvelle instance de [NoPendProcPayout24HError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  NoPendProcPayout24HError(String code)
      : super(code, 'No pending or processed payout within the last 24hours');
}

/// Classe d'erreur si aucun paiement en attente ou traité au cours des 3 derniers mois.
class NoDeposit3MError extends LigdicashError {
  /// Initialise une nouvelle instance de [NoDeposit3MError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  NoDeposit3MError(String code)
      : super(code, 'No deposit withing the last 3 months');
}

/// Classe d'erreur si l'opérateur du destinataire n'a pas été identifié.
class RecipientOperatorNotIdentifiedError extends LigdicashError {
  /// Initialise une nouvelle instance de [RecipientOperatorNotIdentifiedError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  RecipientOperatorNotIdentifiedError(String code)
      : super(code, 'Recipient operator not identified');
}

/// Classe d'erreur si la conversion de devise n'est pas autorisée.
class UnauthorizedCurrencyConversionError extends LigdicashError {
  /// Initialise une nouvelle instance de [UnauthorizedCurrencyConversionError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  UnauthorizedCurrencyConversionError(String code)
      : super(code, 'Unauthorized currency conversion');
}

/// Classe d'erreur si aucun dépôt au cours des dernières 24 heures.
class NoDeposit24HError extends LigdicashError {
  /// Initialise une nouvelle instance de [NoDeposit24HError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  NoDeposit24HError(String code)
      : super(code, 'No deposit withing the last 24 hours');
}

/// Classe d'erreur si le montant demandé est hors de l'interval [20;1000000].
class AmountOutOfRangeError extends LigdicashError {
  /// Initialise une nouvelle instance de [AmountOutOfRangeError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  AmountOutOfRangeError(String code)
      : super(code, 'Request amount is out of range [20;1000000]');
}

/// Classe d'erreur si l'adresse IP est refusée.
class IpDeniedError extends LigdicashError {
  /// Initialise une nouvelle instance de [IpDeniedError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  IpDeniedError(String code) : super(code, 'IP denied');
}

/// Classe d'erreur si une erreur s'est produite pendant le traitement.
class ProcessingError extends LigdicashError {
  /// Initialise une nouvelle instance de [ProcessingError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  ProcessingError(String code)
      : super(code, 'An error occurred while processing');
}

/// Classe d'erreur si une erreur s'est produite lors de l'envoi.
class SendingError extends LigdicashError {
  /// Initialise une nouvelle instance de [SendingError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  SendingError(String code) : super(code, 'An error occurred while processing');
}

/// Classe d'erreur s'il y'a une erreur de saisie de données.
class DataInputError extends LigdicashError {
  /// Initialise une nouvelle instance de [DataInputError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  DataInputError(String code) : super(code, 'Data Input error');
}

/// Classe d'erreur s'il y'a une erreur d'API.
class ApiError extends LigdicashError {
  /// Initialise une nouvelle instance de [ApiError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  ApiError(String code) : super(code, 'Api error');
}

/// Classe d'erreur si aucun hash n'a été fourni.
class NoHashError extends LigdicashError {
  /// Initialise une nouvelle instance de [NoHashError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  NoHashError(String code) : super(code, 'No hash provided');
}

/// Classe d'erreur si le hash est invalide.
class InvalidHashError extends LigdicashError {
  /// Initialise une nouvelle instance de [InvalidHashError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  InvalidHashError(String code) : super(code, 'Invalid hash');
}

/// Classe d'erreur si aucun accès réseau n'est configuré.
class NoNetworkAccessConfigurationError extends LigdicashError {
  /// Initialise une nouvelle instance de [NoNetworkAccessConfigurationError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  NoNetworkAccessConfigurationError(String code)
      : super(code, 'No network access configured');
}

/// Classe d'erreur si la méthode HTTP n'est pas autorisée.
class UnauthorizedMethodError extends LigdicashError {
  /// Initialise une nouvelle instance de [UnauthorizedMethodError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  UnauthorizedMethodError(String code) : super(code, 'Unauthorised method');
}

/// Classe d'erreur si la méthode HTTP est invalide.
class InvalidMethodError extends LigdicashError {
  /// Initialise une nouvelle instance de [InvalidMethodError].
  ///
  /// [code] : Le code d'erreur de Ligdicash.
  InvalidMethodError(String code) : super(code, 'Invalid method');
}

/// Classe d'erreur si la fonctionnalité ne peut pas être utilisée sur la plateforme de test.
class FeatureNotTestableError extends LigdicashError {
  /// Initialise une nouvelle instance de [FeatureNotTestableError].
  ///
  /// [feature_name] : Le nom de la fonctionnalité qui ne peut pas être testée.
  FeatureNotTestableError(String feature_name)
      : super('featurenottestable',
            "$feature_name feature can't be used on test platform");
}
