# Librairie Dart LigdiCash

Ce projet est une librairie Dart qui permet de manipuler l'API de LigdiCash.
Vous pourrez effectuer des Payins, Payouts, des vérifications de transactions et des retraits.

Vous retrouverez la documentation de l'API de LigdiCash sur [https://developers.ligdicash.com/](https://developers.ligdicash.com/).

## Installation

Ajoutez cette ligne à votre fichier `pubspec.yaml` :

```yaml
dependencies:
  ligdicash: ^1.0.1
```

Puis, exécutez :

```bash
dart pub get
```


## Initialisation

L'initialisation de la librairie LigdiCash nécessite une clé API et un jeton d'authentification.
Vous pouvez obtenir ces informations en créant un projet API sur la plateforme LigdiCash.

```dart
import 'package:ligdicash/ligdicash.dart';

var client = new Ligdicash(
  apikey: 'REV...4I4O',
  authToken: 'eyJ0eXAiOiJKV...BJuAY',
  platform: PlatformType.live,
);
```

## Payin

Le Payin est une transaction qui permet à un client de payer pour un produit ou un service.
Il existe deux types de Payin : avec rédirection et sans rédirection.

### Remplir la facture

```dart
// Décrire la facture et le client
var invoice = client.Invoice(
  currency: 'xof',
  description: "Facture pour l'achat de vêtements sur MaSuperBoutique.com",
  customerFirstname: 'Cheik',
  customerLastname: 'Cissé',
  customerEmail: 'cheikcisse@gmail.com',
  storeName: 'MaSuperBoutique',
  storeWebsiteUrl: 'masuperboutique.com',
);

// Ajouter des articles à la facture
invoice.addItem(
  name: 'Jogging Adidas noir',
  description: '__description_du_produit__',
  quantity: 3,
  unitPrice: 3500,
);

invoice.addItem(
  name: 'Veste Gucci motif serpent',
  description: '__description_du_produit__',
  quantity: 1,
  unitPrice: 5000,
);

invoice.addItem(
  name: 'TVA',
  description: '__description_du_produit__',
  quantity: 1,
  unitPrice: 1000,
);
```

### Payin avec rédirection

Le Payin avec rédirection permet de rediriger le client vers une page de paiement sécurisée, conçue par LigdiCash.

```dart
final response = await invoice.payWithRedirection(
  returnUrl: 'https://masuperboutique.com/success',
  cancelUrl: 'https://masuperboutique.com/cancel',
  callbackUrl: 'https://backend.masuperboutique.com/callback',
  customData: {
    'order_id': 'ORD-1234567890',
    'customer_id': 'CUST-1234567890',
  },
);

final paymentUrl = response.responseText;
redirectUser(paymentUrl);
```

### Payin sans rédirection

Le Payin sans rédirection permet de payer directement sur la page de la boutique, sans être redirigé vers une page de paiement.

```dart
final response = await invoice.payWithoutRedirection(
  otp: '101353', // OTP reçu par SMS par le client
  customer: '226XXXXXXXX', // Numéro de téléphone utilisé pour générer l'OTP
  callbackUrl: 'https://backend.masuperboutique.com/callback',
  customData: {
    'order_id': 'ORD-1234567890',
    'customer_id': 'CUST-1234567890',
  },
);

final token = response.token;
checkPaymentStatus(token);
```

## Payout

Le Payout est une transaction qui permet à un marchand de rembourser un client ou de lui envoyer de l'argent.

```dart
var withdrawal = client.Withdrawal(
  amount: 100,
  description: 'Remboursement de la commande ORD-1234567890',
  customer: '226XXXXXXXX',
);
final response = await withdrawal.send(
  type: WithdrawalType.client,
  toWallet: true, // true si l'argent doit rester dans le wallet du client, false si l'argent doit être envoyé sur son compte mobile money
  callbackUrl: 'https://backend.masuperboutique.com/callback-payout',
  customData: {"refund_id": "RFD-123456"}
);

final token = response.token;
checkPaymentStatus(token);
```

## Vérification de transaction

La vérification de transaction permet de vérifier l'état d'une transaction.
Vous devez toujours vérifier l'état d'une transaction avant de livrer un produit ou de valider une commande.

Pour obtenir une transaction, vous devez fournir le token de la transaction.

```dart
final transactionToken = 'eyJ0eXAiOiJ...pZCI6IjY';
final transaction = await client.getTransaction(token: transactionToken, type: TransactionType.payin); // "TransactionType.payin" ou "TransactionType.client_payout" ou "TransactionType.merchant_payout"
final status = transaction.status;
if (status == TransactionStatus.completed) {
  // La transaction a été effectuée avec succès
} else if (status == TransactionStatus.pending) {
  // La transaction est en cours de traitement
} else {
  // La transaction a échouée
}
```