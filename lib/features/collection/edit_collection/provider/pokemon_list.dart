import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/generation_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/region_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/generation_filter_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/name_filter_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/region_filter_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_list.g.dart';

@riverpod
class PokemonList extends _$PokemonList {
  @override
  List<UISearchModel<Pokemon>> build() {
    int? index = ref.read(collectionIndexProvider);
    Collection collection = index == null
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
    List<Generation> generations = ref.read(generationFilterProvider);
    List<Region> regions = ref.read(regionFilterProvider);

    state = state.map((pokemon) {
      bool nameMatch = pokemon.item.name.toLowerCase().contains(
        name.toLowerCase(),
      );
      bool genMatch = generations.every((item) => item.isSelected == false)
          ? true
          : generations
                .where((gen) => pokemon.item.generation == gen.name)
                .first
                .isSelected;
      bool regionMatch = regions.every((item) => item.isSelected == false)
          ? true
          : regions.where((r) => r.isSelected).any(
              (Region r) {
                if (r.name == 'None') {
                  if (pokemon.item.regions == null) {
                    return true;
                  } else if (pokemon.item.regions!.isEmpty) {
                    return true;
                  } else {
                    return false;
                  }
                } else {
                  return pokemon.item.regions?.contains(r.name) ?? false;
                }
              },
              // pokemon.item.regions?.contains(r.name) ?? false,
            );
      return pokemon.copyWith(isVisible: nameMatch && genMatch && regionMatch);
    }).toList();
  }

  void toggle(UISearchModel<Pokemon> pokemon) {
    state = state.map((elem) {
      return pokemon.item.id == elem.item.id
          ? elem.copyWith(isSelected: !elem.isSelected)
          : elem;
    }).toList();
  }

  void selectAllVisible(bool value) {
    state = state.map((elem) {
      return elem.isVisible ? elem.copyWith(isSelected: value) : elem;
    }).toList();
  }

  List<CollectedPokemon> getAlllSelected() {
    int? collectionIndex = ref.read(collectionIndexProvider);
    if (collectionIndex == null) {
      return state
          .where((item) => item.isSelected)
          .map((e) => CollectedPokemon(id: e.item.id))
          .toList();
    } else {
      Collection collection = ref.read(
        collectionStateProvider,
      )[collectionIndex];

      /// List of all captured IDS
      List<int> capturedPokemons =
          collection.pokemons
              ?.where((collectedPokemon) => collectedPokemon.isCaptured)
              .map((collectedPokemon) => collectedPokemon.id)
              .toList() ??
          [];
      List<int> shinyPokemons =
          collection.pokemons
              ?.where((collectedPokemon) => collectedPokemon.isShiny ?? false)
              .map((collectedPokemon) => collectedPokemon.id)
              .toList() ??
          [];
      return state
          .where((item) => item.isSelected)
          .map(
            (e) => CollectedPokemon(
              id: e.item.id,
              isCaptured: capturedPokemons.contains(e.item.id),
              isShiny: shinyPokemons.contains(e.item.id),
            ),
          )
          .toList();
    }
  }
}

// final visiblePokemonListProvider =
//     Provider.autoDispose<List<UISearchModel<Pokemon>>>((ref) {
//       return ref
//           .watch(pokemonListProvider)
//           .where((pokemon) => pokemon.isVisible)
//           .toList();
//     });
