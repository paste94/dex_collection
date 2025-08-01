import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item.dart';
import 'package:dex_collection/features/error_screen/error_screen.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionDetailsScreen extends ConsumerStatefulWidget {
  const CollectionDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState
    extends ConsumerState<CollectionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexProvider);
    if (index == null) {
      return ErrorScreen();
    }
    final Collection collection = ref.watch(collectionStateProvider)[index];
    final pokemonCollection =
        collection.pokemons?.map((e) {
          e.pokemon = ref
              .watch(dbPokemonProvider)
              .firstWhere((pokemon) => pokemon.id == e.id);
          return e;
        }).toList() ??
        [];

    handleEdit() => context.push(ROUTES.editCollection);
    handleDelete() {
      final collectionNotifier = ref.read(collectionStateProvider.notifier);

      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text('Collection ${collection.name} deleted'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  collectionNotifier.unhideCollectionById(collection.id);
                },
              ),
            ),
          )
          .closed
          .then((value) {
            collectionNotifier.deleteHiddenCollections();
          });

      collectionNotifier.hideCollectionById(collection.id);
      context.pop();
    }

    listItemBuilder(BuildContext context, int i) {
      final pokemon = pokemonCollection[i];
      return ListItem(pokemon: pokemon);
    }

    return PopScope(
      onPopInvokedWithResult: (context, result) {
        Future.delayed(
          Duration(milliseconds: 100),
          () => ref.read(indexProvider.notifier).state = null,
        );
      },
      // canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${collection.name}'),
          backgroundColor: Color(collection.color),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    onTap: handleEdit,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.edit),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: handleDelete,
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.delete),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  pokemonCollection.isNotEmpty
                      ? ListView.builder(
                        itemCount: pokemonCollection.length,
                        itemBuilder: listItemBuilder,
                      )
                      : Center(
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.no_pokemon_in_collection,
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
