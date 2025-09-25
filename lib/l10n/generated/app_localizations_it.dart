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
  String get edit_ids => 'Modifica ID';

  @override
  String get delete => 'Cancella';

  @override
  String get unknown_pokemon => 'Pokémon sconosciuto';

  @override
  String get edit_collection => 'Modifica collezione';

  @override
  String get pokemon_details_search_hint => 'Cerca...';

  @override
  String get about => 'Informazioni';

  @override
  String get disclaimer_title => 'Nota legale';

  @override
  String get disclaimer_intro =>
      'Questa è un’applicazione non ufficiale, creata a scopo didattico e personale da un appassionato, utilizzando Flutter e risorse open source.';

  @override
  String get disclaimer_sources =>
      'I dati e le immagini dei Pokémon provengono da PokéAPI (https://pokeapi.co/). Alcune icone sono fornite da Sora e Favicon.io.';

  @override
  String get disclaimer_rights =>
      'Pokémon e i relativi nomi, immagini e marchi appartengono a Nintendo, Game Freak, Creatures Inc. e The Pokémon Company. Questa app non è in alcun modo affiliata, supportata o sponsorizzata da tali enti.';

  @override
  String get disclaimer_open_source =>
      'Il progetto è open source e senza fini di lucro. Se l’app ti è utile, sono aperto a eventuali donazioni per supportarne lo sviluppo.';

  @override
  String get links => 'Links';

  @override
  String get github_repo => 'Repository GitHub';

  @override
  String get paypal_donation_button => 'Offrimi una birrra!';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_database_section => 'Database';

  @override
  String get settings_download_new_db => 'Aggiorna database';

  @override
  String get fetch_error =>
      'Errore nel download, controlla la connessione internet e riprova.';

  @override
  String get downloading => 'Download in corso, attendere...';

  @override
  String get retry => 'Riprova';

  @override
  String get color_picker_title => 'Scegli un colore';

  @override
  String get color_picker_description => 'Scegli un coloper per la collezione';

  @override
  String collection_deleted(String name) {
    return 'Collezione $name eliminata';
  }

  @override
  String get undo => 'Annulla';

  @override
  String get edit_id_title => 'Personalizza ID';

  @override
  String get new_id_label => 'Nuovo ID';

  @override
  String get cancel => 'Annulla';

  @override
  String get ok => 'Ok';

  @override
  String get no_collections_yet =>
      'Non ci sono ancora collezioni.\nPremi + per iniziare!';

  @override
  String get new_collection_tooltip => 'Nuova collezione';
}
