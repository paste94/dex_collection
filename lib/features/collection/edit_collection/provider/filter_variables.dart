import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/generation_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_variables.g.dart';

final nameFilterProvider = StateProvider<String>((ref) => '');

@riverpod
class Generations extends _$Generations {
  @override
  List<Generation> build() {
    return ref
        .read(pokemonListProvider)
        .map(
          (element) => Generation(
            name: element.item.generation ?? 'NULL',
            isSelected: true,
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

// final generationsProvider = StateProvider<List<Generation>>(
//   (ref) =>
//       ref
//           .read(pokemonListProvider)
//           .map((element) => Generation(element.item.generation ?? 'NULL', true))
//           .toSet()
//           .toList(),
// );
