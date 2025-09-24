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

  @override
  String get about => 'About';

  @override
  String get disclaimer_title => 'Disclaimer';

  @override
  String get disclaimer_intro =>
      'This is a non-official application, created as a personal and educational project by a Pokémon fan, using Flutter and open source resources.';

  @override
  String get disclaimer_sources =>
      'Data and images of Pokémon are provided by PokéAPI (https: pokeapi.co/), while some icons and graphics are from Sora and Favicon.io.';

  @override
  String get disclaimer_rights =>
      'Pokémon names, images, and trademarks are the property of their respective owners (Nintendo, Game Freak, Creatures Inc., The Pokémon Company). This app is not affiliated with, endorsed, or sponsored by these entities in any way.';

  @override
  String get disclaimer_open_source =>
      'The project is open source and not-for-profit. If you find the app useful, you’re welcome to support it through donations.';

  @override
  String get links => 'Links';

  @override
  String get github_repo => 'GitHub repo';

  @override
  String get paypal_donation_button => 'Buy me a beer!';
}
