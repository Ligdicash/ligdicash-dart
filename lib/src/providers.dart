import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ligdicash/src/types.dart';

import 'defaults.dart';
import 'wiki.dart';

class HTTPProvider {
  /// La clé API pour l'authentification.
  final String apikey;

  /// Le jeton d'authentification pour l'API.
  final String authToken;

  /// La plateforme utilisée pour envoyer des requêtes HTTP.
  final PlatformType platform;

  /// L'URL de base de l'API.
  final String baseUrl;

  /// La session utilisée pour envoyer des requêtes HTTP.
  final http.Client _client = http.Client();

  HTTPProvider(
      {required String apikey,
      required String authToken,
      required PlatformType platform,
      String? baseUrl})
      : apikey = apikey,
        authToken = authToken,
        platform = platform,
        baseUrl = baseUrl ?? getPlatformUrl(platform) ?? '';

  /// Construit l'URL complète à partir de l'URL de base et de l'URL relative.
  String buildUrl(String url) => baseUrl + url;

  /// Récupère les données de réponse JSON si la réponse HTTP est OK. Sinon, lève une exception.
  Map<String, dynamic> getDataOrRaiseError(
      http.Response response, WikiType feature) {
    if (!(response.statusCode == 200)) {
      throw Exception('Failed to load data: ${response.statusCode}');
    } else {
      final responseData = json.decode(response.body);
      final resCode = responseData['response_code'];
      final resText = responseData['response_text'];
      if (resCode == '00') {
        return responseData;
      } else {
        final errorCode =
            RegExp(r'\d{2,3}[a-z]?').firstMatch(resText)?.group(0);
        final Error = getWikiError(feature, platform, errorCode!);
        throw Error;
      }
    }
  }

  /// Envoie une requête POST à l'API et récupère les données de la réponse.
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> payload, WikiType feature) async {
    final response = await _client.post(
      Uri.parse(buildUrl(url)),
      headers: {
        'Apikey': apikey,
        'Authorization': 'Bearer $authToken',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );
    return getDataOrRaiseError(response, feature);
  }

  /// Envoie une requête GET à l'API et récupère les données de la réponse.
  Future<Map<String, dynamic>> get(String url, WikiType feature) async {
    final response = await _client.get(
      Uri.parse(buildUrl(url)),
      headers: {
        'Apikey': apikey,
        'Authorization': 'Bearer $authToken',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return getDataOrRaiseError(response, feature);
  }
}
