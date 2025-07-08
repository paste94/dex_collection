import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// part 'pokemon_list_provider.g.dart';

final pokemonCollectionProvider = StateProvider<List<PokemonCollection>>((
  Ref ref,
) {
  final index = ref.watch(indexProvider);
  logger.d(
    '[pokemon_list_provider.dart] Fetching PokemonCollection for index: $index',
  );
  if (index == null) {
    return [];
  }
  return ref.watch(collectionStateProvider)[index].pokemons?.map((e) {
        e.pokemon = ref
            .watch(dbPokemonProvider)
            .firstWhere((pokemon) => pokemon.id == e.id);
        return e;
      }).toList() ??
      [];
});
