import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/generation_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/filter_variables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_list.g.dart';

@riverpod
class PokemonList extends _$PokemonList {
  @override
  List<UISearchModel<Pokemon>> build() {
    int? index = ref.read(indexProvider);
    Collection collection =
        index == null
            ? Collection(name: '')
            : ref.read(collectionStateProvider)[index];
    final inCollectionIds =
        collection.pokemons?.map((e) => e.id).toList() ?? [];
    return ref
        .read(dbPokemonProvider)
        .map(
          (e) => UISearchModel<Pokemon>(
            item: e,
            isSelected: inCollectionIds.contains(e.id),
            isVisible: true,
          ),
        )
        .toList();
  }

  void filter() {
    String name = ref.read(nameFilterProvider);
    List<Generation> generations = ref.read(generationsProvider);

    state =
        state
            .map((pokemon) {
              bool nameMatch = pokemon.item.name.toLowerCase().contains(
                name.toLowerCase(),
              );
              bool genMatch =
                  generations
                      .where((gen) => pokemon.item.generation == gen.name)
                      .first
                      .isSelected;
              return pokemon.copyWith(isVisible: nameMatch && genMatch);
            })
            // .where((pokemon) => pokemon.isVisible)
            .toList();
  }

  void toggle(UISearchModel<Pokemon> pokemon) {
    state =
        state.map((elem) {
          return pokemon.item.id == elem.item.id
              ? elem.copyWith(isSelected: !elem.isSelected)
              : elem;
        }).toList();
  }

  void selectAllVisible(bool value) {
    state =
        state.map((elem) {
          return elem.isVisible ? elem.copyWith(isSelected: value) : elem;
        }).toList();
  }

  List<PokemonCollection> getAlllSelected() {
    return state
        .where((item) => item.isSelected)
        .map((e) => PokemonCollection(id: e.item.id))
        .toList();
  }
}

final visiblePokemonListProvider = Provider<List<UISearchModel<Pokemon>>>(
  (ref) =>
      ref
          .watch(pokemonListProvider)
          .where((pokemon) => pokemon.isVisible)
          .toList(),
);
