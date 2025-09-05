import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/details/provider/UIModels/UI_collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
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
    // final collectionId = ref.watch(collectionIdProvider);

    // final Collection collection = ref
    //     .watch(collectionStateProvider)
    //     .where((element) => element.id == collectionId)
    //     .first;

    final List<UICollection<CollectedPokemon>> pokemonCollection = ref
        .watch(uICollectionStateProvider)
        .where((p) => p.isVisible)
        .toList();

    // final pokemonCollection = collection.pokemons!;

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
