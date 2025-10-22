import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/details/provider/UIModels/UI_collection.dart';
import 'package:dex_collection/features/collection/details/provider/details_search_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ui_collection_provider.g.dart';

@Riverpod()
class UICollectionList extends _$UICollectionList {
  @override
  List<UICollection<CollectedPokemon>> build() {
    ref.listen(detailsSearchProvider, (oldValue, newValue) => filter(newValue));

    List<CollectedPokemon>? pokemons = ref.watch(
      collectionItemProvider(
        ref.watch(collectionIdProvider),
      ).select((c) => c.pokemons),
    );

    List<UICollection<CollectedPokemon>> list =
        pokemons?.map((CollectedPokemon e) {
          final pokemon = e.copyWith(
            pokemon: ref
                .read(dbPokemonProvider)
                .firstWhere((pokemon) => pokemon.id == e.id),
          );
          return UICollection(item: pokemon);
        }).toList() ??
        [];

    /// Apply filter
    final filterStr = ref.read(detailsSearchProvider);
    if (filterStr.isNotEmpty) {
      final query = filterStr.trim().toLowerCase();

      list = [
        for (final element in list)
          element.copyWith(
            isVisible: query.isEmpty
                ? true
                : (element.item.pokemon?.name.toLowerCase().contains(query) ??
                      true),
          ),
      ];
    }
    return list;
  }

  void filter(String value) {
    final query = value.trim().toLowerCase();

    state = [
      for (final element in state)
        element.copyWith(
          isVisible: query.isEmpty
              ? true
              : (element.item.pokemon?.name.toLowerCase().contains(query) ??
                    true),
        ),
    ];
  }
}
