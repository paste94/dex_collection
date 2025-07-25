import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class FilteredPokemonList extends _$FilteredPokemonList {
  @override
  List<UISearchModel<Pokemon>> build() {
    final initialList = ref.read(dbPokemonProvider);
    return initialList
        .map(
          (e) => UISearchModel<Pokemon>(
            item: e,
            isSelected: false,
            isVisible: true,
          ),
        )
        .toList();
  }

  void filterPokemon(String query) {
    final term = query.toLowerCase();
    state =
        state.map((uiModel) {
          final matches = uiModel.item.name.toLowerCase().contains(term);
          return uiModel.copyWith(isVisible: matches);
        }).toList();
  }

  void toggleSelection(int id) {
    state =
        state.map((uiModel) {
          if (uiModel.item.id == id) {
            return uiModel.copyWith(isSelected: !uiModel.isSelected);
          }
          return uiModel;
        }).toList();
  }
}
