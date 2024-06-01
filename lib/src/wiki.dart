import 'package:ligdicash/src/types.dart';

import 'errors.dart';

final Map<PlatformType, Map<String, Function(String)>> PAYOUT_CLIENT_WIKI = {
  PlatformType.test: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new MerchantPayoutDisabledError(code),
    '02': (String code) => new CustomerDoesNotExistError(code),
    '03': (String code) => new MerchantAccountDoesNotExistError(code),
    '03a': (String code) => new NoPendProcPayout24HError(code),
    '03b': (String code) => new NoDeposit3MError(code),
    '04': (String code) => new MerchantBalanceLowError(code),
    '05': (String code) => new AmountOutOfRangeError(code),
    '06': (String code) => new IpDeniedError(code),
    '07': (String code) => new TransactionAlreadyExistError(code),
    '08': (String code) => new ProcessingError(code),
    '09': (String code) => new DataInputError(code),
    '10': (String code) => new ApiError(code),
    '13': (String code) => new NoHashError(code),
    '14': (String code) => new InvalidHashError(code),
  },
  PlatformType.live: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new MerchantPayoutDisabledError(code),
    '02': (String code) => new CustomerDoesNotExistError(code),
    '03': (String code) => new MerchantAccountDoesNotExistError(code),
    '03a': (String code) => new NoPendProcPayout24HError(code),
    '03b': (String code) => new NoDeposit3MError(code),
    '04': (String code) => new MerchantBalanceLowError(code),
    '05': (String code) => new AmountOutOfRangeError(code),
    '06': (String code) => new IpDeniedError(code),
    '07': (String code) => new TransactionAlreadyExistError(code),
    '08': (String code) => new ProcessingError(code),
    '09': (String code) => new DataInputError(code),
    '10': (String code) => new ApiError(code),
    '13': (String code) => new NoHashError(code),
    '14': (String code) => new InvalidHashError(code),
  },
};

final Map<PlatformType, Map<String, Function(String)>> PAYOUT_MARCHAND_WIKI = {
  PlatformType.test: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new ApplicationAuthenticationError(code),
    '02': (String code) => new AmountOutOfRangeError(code),
    '03': (String code) => new MerchantAccountDoesNotExistError(code),
    '04': (String code) => new NoPendProcPayout24HError(code),
    '05': (String code) => new RecipientOperatorNotIdentifiedError(code),
    '06': (String code) => new MerchantAccountDoesNotExistError(code),
    '07': (String code) => new MerchantAccountDoesNotExistError(code),
    '08': (String code) => new MerchantBalanceLowError(code),
    '09': (String code) => new UnauthorizedCurrencyConversionError(code),
    '10': (String code) => new IpDeniedError(code),
    '11': (String code) => new NoDeposit24HError(code),
  },
  PlatformType.live: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new ApplicationAuthenticationError(code),
    '02': (String code) => new AmountOutOfRangeError(code),
    '03': (String code) => new MerchantAccountDoesNotExistError(code),
    '04': (String code) => new NoPendProcPayout24HError(code),
    '05': (String code) => new RecipientOperatorNotIdentifiedError(code),
    '06': (String code) => new MerchantAccountDoesNotExistError(code),
    '07': (String code) => new MerchantAccountDoesNotExistError(code),
    '08': (String code) => new MerchantBalanceLowError(code),
    '09': (String code) => new UnauthorizedCurrencyConversionError(code),
    '10': (String code) => new IpDeniedError(code),
    '11': (String code) => new NoDeposit24HError(code),
  },
};

final Map<PlatformType, Map<String, Function(String)>> PAYIN_WIKI = {
  PlatformType.test: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new InvalidAmountError(code),
    '02': (String code) => new InvalidTokenError(code),
    '03': (String code) => new MerchantAccountDoesNotExistError(code),
    '04': (String code) => new ProcessingError(code),
    '05': (String code) => new SendingError(code),
    '06': (String code) => new SendingError(code),
    '07': (String code) => new NoNetworkAccessConfigurationError(code),
    '08': (String code) => new DataInputError(code),
    '09': (String code) => new ApiError(code),
    '10': (String code) => new NoHashError(code),
    '11': (String code) => new InvalidHashError(code),
    '12': (String code) => new InvalidMethodError(code),
    '13': (String code) => new UnauthorizedMethodError(code),
  },
  PlatformType.live: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new InvalidAmountError(code),
    '02': (String code) => new InvalidTokenError(code),
    '03': (String code) => new MerchantAccountDoesNotExistError(code),
    '04': (String code) => new ProcessingError(code),
    '05': (String code) => new SendingError(code),
    '06': (String code) => new SendingError(code),
    '07': (String code) => new NoNetworkAccessConfigurationError(code),
    '08': (String code) => new DataInputError(code),
    '09': (String code) => new ApiError(code),
    '10': (String code) => new NoHashError(code),
    '11': (String code) => new InvalidHashError(code),
    '12': (String code) => new InvalidMethodError(code),
    '13': (String code) => new UnauthorizedMethodError(code),
  },
};

final Map<PlatformType, Map<String, Function(String)>> STATUS_WIKI = {
  PlatformType.test: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new ApplicationAuthenticationError(code),
    '02': (String code) => new InvoiceNotFoundError(code),
    '03': (String code) => new ProcessingError(code),
  },
  PlatformType.live: {
    '00': (String code) => new AuthenticationError(code),
    '01': (String code) => new MerchantPayinDisabledError(code),
    '02': (String code) => new InvoiceNotFoundError(code),
    '03': (String code) => new ProcessingError(code),
    '04': (String code) => new DataInputError(code),
  },
};

final Map<WikiType, Map<PlatformType, Map<String, Function(String)>>> WIKI = {
  WikiType.payin: PAYIN_WIKI,
  WikiType.client_payout: PAYOUT_CLIENT_WIKI,
  WikiType.merchant_payout: PAYOUT_MARCHAND_WIKI,
  WikiType.status: STATUS_WIKI,
};

LigdicashError getWikiError(
    WikiType wikiName, PlatformType platform, String errorCode) {
  if (WIKI.containsKey(wikiName) &&
      WIKI[wikiName]!.containsKey(platform) &&
      WIKI[wikiName]![platform]!.containsKey(errorCode)) {
    return WIKI[wikiName]![platform]![errorCode]!(errorCode);
  }
  return ApiError(errorCode);
}
