import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/details/provider/UIModels/UI_collection.dart';
import 'package:dex_collection/features/collection/details/provider/details_search_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ui_collection_provider.g.dart';

@riverpod
class UICollectionState extends _$UICollectionState {
  @override
  List<UICollection<CollectedPokemon>> build() {
    ref.listen(detailsSearchProvider, (oldValue, newValue) => filter(newValue));

    return ref
        .read(collectionStateProvider.notifier)
        .getSelectedCollectionPokemons()
        .map((p) => UICollection(item: p))
        .toList();
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
