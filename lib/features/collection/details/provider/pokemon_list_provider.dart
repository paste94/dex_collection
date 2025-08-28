import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// part 'pokemon_list_provider.g.dart';

final pokemonCollectionProvider =
    StateProvider.autoDispose<List<CollectedPokemon>>((Ref ref) {
      // final index = ref.watch(collectionIndexProvider);
      final collectionId = ref.watch(collectionIdProvider);
      logger.d(
        '[pokemon_list_provider.dart] Fetching PokemonCollection for id: $collectionId',
      );
      if (collectionId == null) {
        return [];
      }
      // return ref.watch(collectionStateProvider)[index].pokemons?.map((e) {
      //       e.pokemon = ref
      //           .watch(dbPokemonProvider)
      //           .firstWhere((pokemon) => pokemon.id == e.id);
      //       return e;
      //     }).toList() ??
      //     [];
      return ref
              .watch(collectionStateProvider)
              .where((element) => element.id == collectionId)
              .first
              .pokemons
              ?.map((e) {
                e.pokemon = ref
                    .watch(dbPokemonProvider)
                    .firstWhere((pokemon) => pokemon.id == e.id);
                return e;
              })
              .toList() ??
          [];
    });
