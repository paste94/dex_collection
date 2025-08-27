// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get title => 'Dex Collection';

  @override
  String get home_title => 'Home';

  @override
  String get create_collection => 'Crea Collezione';

  @override
  String get pokemon_search_hint => 'Cerca per nome o forma';

  @override
  String get edit_collection_name_hint => 'Modifica nome collezione';

  @override
  String get no_pokemon_in_collection =>
      'Non ci sono pokémon in questa collezione';

  @override
  String get edit => 'Modifica';

  @override
  String get delete => 'Cancella';

  @override
  String get unknown_pokemon => 'Pokémon sconosciuto';

  @override
  String get edit_collection => 'Modifica collezione';
}
