import 'package:cached_network_image/cached_network_image.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/details/provider/pokemon_list_provider.dart';
import 'package:dex_collection/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class CollectionDetailsScreen extends ConsumerWidget {
  // int? index;
  const CollectionDetailsScreen({
    super.key,
    // required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providedIndex = ref.watch(indexProvider);
    logger.d(
      '[collection_details_screen.dart] Collection index: $providedIndex',
    );
    if (providedIndex == null) {
      // Se l'indice non è fornito, mostra un errore o una schermata vuota
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Collection providedIndex is not provided')),
      );
    }
    final Collection collection =
        ref.watch(collectionStateProvider)[providedIndex];
    logger.d(
      '[collection_details_screen.dart] Collection details for providedIndex $providedIndex: ${collection.pokemons?.length}',
    );
    // final pokemonCollection = ref.watch(pokemonListProvider);
    final pokemonCollection =
        collection.pokemons?.map((e) {
          e.pokemon = ref
              .watch(dbPokemonProvider)
              .firstWhere((pokemon) => pokemon.id == e.id);
          return e;
        }).toList() ??
        [];
    logger.d(
      '[collection_details_screen.dart] Collection details for providedIndex $providedIndex: ${pokemonCollection.length}',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('${collection.name}'),
        backgroundColor: Color(collection.color),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                pokemonCollection.isNotEmpty
                    ? ListView.builder(
                      itemCount: pokemonCollection.length,
                      itemBuilder: (context, i) {
                        final pokemon = pokemonCollection[i];
                        return ListTile(
                          title: Text(
                            pokemon.pokemon?.name ?? 'Unknown Pokémon',
                          ),
                          leading: CachedNetworkImage(
                            imageUrl: pokemon.pokemon?.img ?? '',
                            placeholder:
                                (context, url) => CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) => Icon(Icons.error),
                          ),
                          onTap: () {
                            // Naviga alla schermata di dettaglio del Pokémon
                          },
                        );
                      },
                    )
                    : Center(child: Text('No Pokémon in this collection')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/collection/search'),
        tooltip: 'Add new collection',
        child: Icon(Icons.add),
      ),
    );
  }
}
