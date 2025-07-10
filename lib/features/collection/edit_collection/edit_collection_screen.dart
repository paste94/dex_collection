import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/btn_color_picker.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/lst_pokemon_to_add.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/txt_collection_name.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/txt_search_bar.dart';
import 'package:dex_collection/features/error_screen/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditCollectionScreen extends ConsumerStatefulWidget {
  const EditCollectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCollectionScreenState();
}

class _EditCollectionScreenState extends ConsumerState<EditCollectionScreen> {
  final _textController = TextEditingController();
  final _collectionNameController = TextEditingController();
  late List<UISearchModel<Pokemon>> pokemonList;
  late Color selectedColor;
  late Collection collection;
  late int? index;

  @override
  void initState() {
    index = ref.read(indexProvider);
    final initialList = ref.read(dbPokemonProvider);

    setState(() {
      collection =
          index == null
              ? Collection(name: '')
              : ref.read(collectionStateProvider)[index!];
      selectedColor = Color(collection.color);
      final inCollectionIds =
          collection.pokemons?.map((e) => e.id).toList() ?? [];
      pokemonList =
          initialList
              .map(
                (e) => UISearchModel<Pokemon>(
                  item: e,
                  isSelected: inCollectionIds.contains(e.id),
                  isVisible: true,
                ),
              )
              .toList();
    });
    _collectionNameController.text = collection.name ?? '';

    super.initState();
  }

  onDispose() {
    _textController.dispose();
    _collectionNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems =
        pokemonList.where((pokemon) => pokemon.isVisible).toList();
    // final Collection collection = ref.watch(collectionStateProvider)[index];

    void toggle(UISearchModel<Pokemon> pokemon) => setState(() {
      pokemonList.where((item) => item.item.id == pokemon.item.id).forEach((
        item,
      ) {
        item.isSelected = !item.isSelected;
      });
    });

    void addPokemonListToCollection() {
      ref
          .read(collectionStateProvider.notifier)
          .addOrUpdateCollection(
            collection.copyWith(
              name: _collectionNameController.text,
              color: selectedColor.toARGB32(),
              pokemons:
                  pokemonList
                      .where((item) => item.isSelected)
                      .map((e) => PokemonCollection(id: e.item.id))
                      .toList(),
            ),
            // Collection(
            //   name: _collectionNameController.text,
            //   color: selectedColor.toARGB32(),
            //   pokemons:
            //       pokemonList
            //           .where((item) => item.isSelected)
            //           .map((e) => PokemonCollection(id: e.item.id))
            //           .toList(),
            // ),
          );
      // ref
      //     .read(collectionStateProvider.notifier)
      //     .addPokemonListToCollection(
      //       collection.id,
      //       pokemonList
      //           .where((item) => item.isSelected)
      //           .map((e) => e.item)
      //           .toList(),
      //     );
      // if (collection.name != _collectionNameController.text) {
      //   ref
      //       .read(collectionStateProvider.notifier)
      //       .updateName(collection.id, _collectionNameController.text);
      // }
      // if (collection.color != selectedColor.toARGB32()) {
      //   ref
      //       .read(collectionStateProvider.notifier)
      //       .updateColor(collection.id, selectedColor);
      // }
      if (mounted) {
        context.pop();
      }
    }

    _textController.addListener(() {
      setState(() {
        pokemonList =
            pokemonList.map((element) {
              final matches = element.item.name.toLowerCase().contains(
                _textController.text.toLowerCase(),
              );
              return element.copyWith(isVisible: matches);
            }).toList();
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(index == null ? 'Create collection' : 'Edit collection'),
        backgroundColor: selectedColor,
        actions: [
          IconButton(
            onPressed: addPokemonListToCollection,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TxtCollectionName(
                    controller: _collectionNameController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: BtnColorPicker(
                  selectedColor: selectedColor,
                  selectedColorCallback:
                      (newColor) => setState(() {
                        selectedColor = newColor;
                      }),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TxtSearchBar(controller: _textController),
          ),
          Expanded(
            child: LstPokemonToAdd(visibleItems: visibleItems, toggle: toggle),
          ),
        ],
      ),
    );
  }
}
