import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/region_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_filter_provider.g.dart';

@riverpod
class RegionFilter extends _$RegionFilter {
  @override
  List<Region> build() {
    return ref
        .read(pokemonListProvider)
        .where((element) => element.item.regions != null)
        .expand(
          (element) => element.item.regions!.map(
            (region) => Region(name: region, isSelected: false),
          ),
        )
        .toSet()
        .toList()
      ..insert(0, Region(name: 'None', isSelected: false));
  }

  void select(Region region, bool value) {
    state =
        state.map((item) {
          return item == region ? item.copyWith(isSelected: value) : item;
        }).toList();
  }
}
