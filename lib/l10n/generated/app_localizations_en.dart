// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Dex Collection';

  @override
  String get home_title => 'Home';

  @override
  String get create_collection => 'Create Collection';

  @override
  String get pokemon_search_hint => 'Search by name or form';

  @override
  String get edit_collection_name_hint => 'Edit collection name';

  @override
  String get no_pokemon_in_collection => 'No Pokémon in this collection';

  @override
  String get edit => 'Edit';

  @override
  String get edit_ids => 'Edit IDs';

  @override
  String get delete => 'Delete';

  @override
  String get unknown_pokemon => 'Unknown Pokémon';

  @override
  String get edit_collection => 'Edit collection';

  @override
  String get pokemon_details_search_hint => 'Search...';
}
