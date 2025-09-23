import 'dart:convert';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/config/config.dart';
// ignore: unused_import
import 'package:dex_collection/main.dart';
import 'package:http/http.dart' as http;

class PokeapiService {
  static Future<String> getUrl() async {
    final urlLatest = Uri.parse(URL_REPO);

    // 1. Ottieni la release più recente
    final response = await http.get(urlLatest);
    if (response.statusCode != 200) {
      throw Exception("Errore nel recupero della release: ${response.body}");
    }

    final release = jsonDecode(response.body);

    // 2. Trova l’asset che ti serve
    String? assetUrl;
    for (final asset in release["assets"]) {
      if (asset["name"] == ASSET_NAME) {
        assetUrl = asset["browser_download_url"];
        break;
      }
    }

    if (assetUrl == null) {
      throw Exception("Asset $ASSET_NAME non trovato nella release");
    }

    return assetUrl;
  }

  static Future<List<Pokemon>> getAllPokemons() async {
    // https://github.com/paste94/dex_collector_downloader/releases/download/v1.0.0/pokemon_list.json

    String assetUrl = await getUrl();

    final assetResponse = await http.get(Uri.parse(assetUrl));
    if (assetResponse.statusCode != 200) {
      throw Exception("Errore nel download del asset: ${assetResponse.body}");
    }

    List<dynamic> data = jsonDecode(assetResponse.body);

    return data
        .where(checkIsValidVariety)
        .map((item) => Pokemon.fromJson(item))
        .toList();
  }

  static bool checkIsValidVariety(item) {
    bool isValid = false;
    if (item['is_default']) {
      isValid = true;
    } else if (REGIONAL_FORMS.any((region) => item['name'].contains(region)) &&
        !NON_VALID_REGIONAL_FORM.any(
          (region) => item['name'].contains(region),
        )) {
      isValid = true;
    }
    return isValid;
  }
}
