import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/generation_filter_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/name_filter_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/region_filter_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/selected_collection.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/btn_color_picker.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/chk_select_all.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/filter/btn_filter.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/lst_pokemon_to_add.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/txt_collection_name.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/txt_search_bar.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
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
  late Color selectedColor;

  @override
  void initState() {
    final collection = ref.read(selectedCollectionProvider);
    setState(() {
      selectedColor = Color(collection.color);
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
    // final visibleItems = ref.watch(visiblePokemonListProvider);
    final visibleItems =
        ref
            .watch(pokemonListProvider)
            .where((pokemon) => pokemon.isVisible)
            .toList();
    final index = ref.read(indexProvider);
    final collection = ref.watch(selectedCollectionProvider);
    // DEVE RIMANERE QUA sennò il filtro non funziona
    ref.watch(generationFilterProvider);
    ref.watch(regionFilterProvider);

    final isAllSelected = visibleItems.every((element) => element.isSelected);
    final howManySelected =
        visibleItems.where((element) => element.isSelected).length;

    void handleSelectColor(newColor) =>
        setState(() => selectedColor = newColor);

    void handleDeleteChip() =>
        ref.read(pokemonListProvider.notifier).selectAllVisible(false);

    void handleAddPokemons() {
      ref
          .read(collectionStateProvider.notifier)
          .addOrUpdateCollection(
            collection.copyWith(
              name: _collectionNameController.text,
              color: selectedColor.toARGB32(),
              pokemons:
                  ref.read(pokemonListProvider.notifier).getAlllSelected(),
            ),
          );
      if (mounted) {
        context.pop();
      }
    }

    _textController.addListener(() {
      ref.read(nameFilterProvider.notifier).state = _textController.text;
      ref.read(pokemonListProvider.notifier).filter();
    });

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
          Expanded(child: LstPokemonToAdd(visibleItems: visibleItems)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            ChkSelectAll(value: isAllSelected),
            BtnFilter(),
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
