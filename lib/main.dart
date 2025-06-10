import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/models/collection.dart';
import 'package:dex_collection/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CollectionAdapter());
  await Hive.openBox<Collection>(COLLECTION_BOX);

  // _box.clear(); // Clear the box for testing purposes

  // ..registerAdapter(PokemonAdapter())
  // ..registerAdapter(CollectionAdapter())
  // ..openBox(COLLECTION_BOX)
  // ..openBox(POKEMON_BOX);

  runApp(ProviderScope(child: MyApp()));
}

var logger = Logger();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Downlods all pokemons from pokeAPI. Saves it in Hive
    // fetchPokemon();

    return MaterialApp.router(
      title: 'Dex Collection',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
