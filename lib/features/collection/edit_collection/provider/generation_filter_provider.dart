import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/generation_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generation_filter_provider.g.dart';

@riverpod
class GenerationFilter extends _$GenerationFilter {
  @override
  List<Generation> build() {
    return ref
        .read(pokemonListProvider)
        .map(
          (element) => Generation(
            name: element.item.generation ?? 'NULL',
            isSelected: false,
          ),
        )
        .toSet()
        .toList();
  }

  void select(Generation generation, bool value) {
    state =
        state.map((item) {
          return item == generation ? item.copyWith(isSelected: value) : item;
        }).toList();
  }
}
