import 'package:cached_network_image/cached_network_image.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/search/provider/search_provider.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  // int? index;

  SearchScreen({
    super.key,
    // required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _textController = TextEditingController();

  String formatName(String name) {
    return name
        .replaceAll('-', ' ')
        .replaceAll('alola', 'Alola')
        .replaceAll('galar', 'Galar')
        .replaceAll('hisui', 'Hisui')
        .replaceAll('paldea', 'Paldea')
        .replaceAllMapped(
          RegExp(r'(^\w|\s\w)'),
          (match) => match.group(0)!.toUpperCase(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexProvider);
    if (index == null) {
      // Se l'indice non è fornito, mostra un errore o una schermata vuota
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Collection index is not provided')),
      );
    }
    final pokemonList = ref.watch(filteredPokemonListProvider);
    final visibleItems =
        pokemonList.where((pokemon) => pokemon.isVisible).toList();
    _textController.addListener(() {
      ref
          .read(filteredPokemonListProvider.notifier)
          .filterPokemon(_textController.text);
    });
    final Collection collection = ref.watch(collectionStateProvider)[index];

    void toggle(pokemon) =>
        ref.read(filteredPokemonListProvider.notifier).toggleSelection(pokemon);

    void addPokemonListToCollection() {
      ref
          .read(collectionStateProvider.notifier)
          .addPokemonListToCollection(
            collection.id,
            visibleItems
                .where((item) => item.isSelected)
                .map((e) => e.item)
                .toList(),
          );
      if (mounted) {
        context.pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cerca Pokémon'),
        backgroundColor: Color(collection.color),
        actions: [
          IconButton(
            onPressed: addPokemonListToCollection,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.pokemon_search_hint,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                suffixIcon:
                    _textController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _textController.clear();
                          },
                        )
                        : null,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visibleItems.length,
              itemBuilder: (context, index) {
                final pokemon = visibleItems[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: pokemon.item.img,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(formatName(pokemon.item.name)),
                  trailing:
                      pokemon.isSelected
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(Icons.circle_outlined),
                  onTap: () => toggle(pokemon),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
