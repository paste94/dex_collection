import 'package:dex_collection/Hive/box_const.dart';
import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/router/app_router.dart';
import 'package:dex_collection/utility/riverpod_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk(COLLECTION_BOX);
  // await Hive.deleteBoxFromDisk(POKEMON_BOX);

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CollectionAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PokemonAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(CollectedPokemonAdapter());
  }

  await Hive.openBox<Collection>(COLLECTION_BOX);
  await Hive.openBox<Pokemon>(POKEMON_BOX);

  runApp(ProviderScope(observers: [RiverpodLogger()], child: MyApp()));
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
