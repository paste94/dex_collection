import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// Main app title
  ///
  /// In en, this message translates to:
  /// **'Dex Collection'**
  String get title;

  /// Title for home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_title;

  /// Create collection screen title
  ///
  /// In en, this message translates to:
  /// **'Create Collection'**
  String get create_collection;

  /// Search hint for Pokémon
  ///
  /// In en, this message translates to:
  /// **'Search by name or form'**
  String get pokemon_search_hint;

  /// Edit collection name hint
  ///
  /// In en, this message translates to:
  /// **'Edit collection name'**
  String get edit_collection_name_hint;

  /// Message shown when there are no Pokémon in a collection
  ///
  /// In en, this message translates to:
  /// **'No Pokémon in this collection'**
  String get no_pokemon_in_collection;

  /// Edit action label
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Edit IDs label
  ///
  /// In en, this message translates to:
  /// **'Edit IDs'**
  String get edit_ids;

  /// Delete action label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Label for unknown Pokémon
  ///
  /// In en, this message translates to:
  /// **'Unknown Pokémon'**
  String get unknown_pokemon;

  /// Label for edit collection title screen
  ///
  /// In en, this message translates to:
  /// **'Edit collection'**
  String get edit_collection;

  /// Search hint for Pokémon details screen
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get pokemon_details_search_hint;

  /// About screen title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Disclaimer section title
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer_title;

  /// Discmlaimer text
  ///
  /// In en, this message translates to:
  /// **'This is a non-official application, created as a personal and educational project by a Pokémon fan, using Flutter and open source resources.'**
  String get disclaimer_intro;

  /// Discmlaimer text
  ///
  /// In en, this message translates to:
  /// **'Data and images of Pokémon are provided by PokéAPI (https: pokeapi.co/), while some icons and graphics are from Sora and Favicon.io.'**
  String get disclaimer_sources;

  /// Discmlaimer text
  ///
  /// In en, this message translates to:
  /// **'Pokémon names, images, and trademarks are the property of their respective owners (Nintendo, Game Freak, Creatures Inc., The Pokémon Company). This app is not affiliated with, endorsed, or sponsored by these entities in any way.'**
  String get disclaimer_rights;

  /// Discmlaimer text
  ///
  /// In en, this message translates to:
  /// **'The project is open source and not-for-profit. If you find the app useful, you’re welcome to support it through donations.'**
  String get disclaimer_open_source;

  /// Links title
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get links;

  /// GitHub Repo btn text
  ///
  /// In en, this message translates to:
  /// **'GitHub repo'**
  String get github_repo;

  /// Buy me a beer button
  ///
  /// In en, this message translates to:
  /// **'Buy me a beer!'**
  String get paypal_donation_button;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
