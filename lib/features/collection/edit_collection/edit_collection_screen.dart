import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/generation_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/btn_color_picker.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/lst_pokemon_to_add.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/txt_collection_name.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/txt_search_bar.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/main.dart';
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
  late List<Generation> generations;
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
      generations =
          pokemonList
              .map(
                (element) =>
                    Generation(element.item.generation ?? 'NULL', true),
              )
              .toSet()
              .toList();
      // generationsFilter = generations;
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

    final isAllSelected = visibleItems.every((element) => element.isSelected);
    final howManySelected =
        visibleItems.where((element) => element.isSelected).length;

    void toggle(UISearchModel<Pokemon> pokemon) => setState(() {
      pokemonList.where((item) => item.item.id == pokemon.item.id).forEach((
        item,
      ) {
        item.isSelected = !item.isSelected;
      });
    });

    void handleSelectAllChange(bool? value) {
      if (value == null) {
        return;
      }
      setState(() {
        for (var item in visibleItems) {
          item.isSelected = value;
        }
      });
    }

    void handleSelectColor(newColor) =>
        setState(() => selectedColor = newColor);

    void handleDeleteChip() => handleSelectAllChange(false);

    void handleAddPokemons() {
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
          );
      if (mounted) {
        context.pop();
      }
    }

    // void handleFilterGeneration(String? value) {
    //   if(value == null){
    //     setState(() => visibleItems = pokemonList);
    //   }
    //   setState(() => visibleItems = pokemonList.where((pokemon) => pokemon.),)
    // }

    void filter() {
      setState(() {
        pokemonList =
            pokemonList.map((pokemon) {
              bool nameMatch = pokemon.item.name.toLowerCase().contains(
                _textController.text.toLowerCase(),
              );
              bool genMatch =
                  generations
                      .where(
                        (Generation gen) => pokemon.item.generation == gen.name,
                      )
                      .first
                      .isSelected;
              return pokemon.copyWith(isVisible: nameMatch && genMatch);
            }).toList();
      });
    }

    _textController.addListener(filter);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          index == null
              ? AppLocalizations.of(context)!.create_collection
              : AppLocalizations.of(context)!.edit_collection,
        ),
        backgroundColor: selectedColor,
        actions: [
          IconButton(onPressed: handleAddPokemons, icon: Icon(Icons.check)),
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
                  selectedColorCallback: handleSelectColor,
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Checkbox(value: isAllSelected, onChanged: handleSelectAllChange),
            IconButton(
              icon: Icon(Icons.filter_alt),
              onPressed:
                  () => showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return StatefulBuilder(
                        builder:
                            (
                              BuildContext context,
                              StateSetter setModalState,
                            ) => Column(
                              children: [
                                Text('Generation'),
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    children:
                                        generations
                                            .map(
                                              (gen) => ChoiceChip(
                                                label: Text(gen.name),
                                                selected: gen.isSelected,
                                                onSelected: (bool selected) {
                                                  setModalState(() {
                                                    gen.isSelected = selected;
                                                  });
                                                  filter();
                                                },
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
            ),
            Expanded(child: SizedBox()),
            howManySelected != 0
                ? Chip(
                  onDeleted: handleDeleteChip,
                  deleteIcon: Icon(Icons.close),
                  label: Text('$howManySelected'),
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
