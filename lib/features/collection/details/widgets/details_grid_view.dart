import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/features/collection/details/provider/UIModels/UI_collection.dart';
import 'package:dex_collection/features/collection/details/provider/ui_collection_provider.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item/list_item.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsGridView extends ConsumerWidget {
  const DetailsGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UICollection<CollectedPokemon>> pokemonCollection = ref
        .watch(uICollectionListProvider)
        .where((p) => p.isVisible)
        .toList();

    logger.i(pokemonCollection);

    return pokemonCollection.isNotEmpty
        ? GridView.count(
            crossAxisCount: 2,
            children: pokemonCollection
                .map(
                  (p) => GridTile(
                    key: ValueKey(p.item.id),
                    child: ListItem(pokemon: p.item),
                  ),
                )
                .toList(),
          )
        : Center(
            child: Text(AppLocalizations.of(context)!.no_pokemon_in_collection),
          );
  }
}
