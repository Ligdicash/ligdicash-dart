/// Enum pour le type de transaction
enum PlatformType { test, live }

/// Enum pour le type de wiki
enum WikiType { payin, client_payout, merchant_payout, status }

/// Enum pour le statut de la transaction
enum TransactionStatus { pending, completed, nocompleted }

/// Enum pour le type de retrait
enum WithdrawalType { client, merchant }

enum TransactionType { payin, client_payout, merchant_payout }
