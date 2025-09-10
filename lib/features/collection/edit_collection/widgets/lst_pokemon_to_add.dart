import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/list_item/itm_pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LstPokemonToAdd extends ConsumerWidget {
  final List<UISearchModel<Pokemon>> visibleItems;
  const LstPokemonToAdd({super.key, required this.visibleItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: visibleItems.length,
      itemBuilder: (context, index) {
        final pokemon = visibleItems[index];
        return ItemPokemon(uiPokemon: pokemon);
      },
    );
  }
}
