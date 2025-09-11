import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/details/widgets/dialog_edit_id.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item/widgets/btn_captured.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item/widgets/btn_shiny.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item/widgets/pokemon_image.dart';
import 'package:dex_collection/utility/common_funcions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListItem extends ConsumerWidget {
  final CollectedPokemon cPokemon;
  const ListItem({super.key, required this.cPokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Providers
    // final collectionIndex = ref.watch(collectionIndexProvider)!;
    String? collectionId = ref.watch(collectionIdProvider)!;

    /// Functions
    Color? cardColorFromPokemon() => cPokemon.isCaptured
        ? Color(cPokemon.pokemon!.color ?? 0)
        : Theme.of(context).cardTheme.color;

    /// Handlers
    onCapturedTap() => ref
        .read(collectionListProvider.notifier)
        .toggleCaptured(collectionId, cPokemon.id);

    onShinyTap() => ref
        .read(collectionListProvider.notifier)
        .toggleShiny(collectionId, cPokemon.id);

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: Card(
        // key: ValueKey<String>  (cardColorFromPokemon().toString()),
        color: cardColorFromPokemon(),
        child: InkWell(
          borderRadius: BorderRadius.circular(getCardCornerRadius(context)),

          onLongPress: () => showDialog(
            context: context,
            builder: (context) => DialogEditId(cPokemon: cPokemon),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NAME
                    Text(
                      formatName(cPokemon.pokemon!),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    /// ID
                    Text(
                      '${cPokemon.customId}',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ),

                    /// Useful for card width, do not remove!
                    Row(),
                  ],
                ),
              ),

              /// BTN SHINY
              Positioned(
                bottom: 0,
                child: BtnShiny(
                  isShiny: cPokemon.isShiny ?? false,
                  onTap: onShinyTap,
                ),
              ),

              /// BTN CAPTURED
              Positioned(
                top: 0,
                right: 0,
                child: BtnCaptured(
                  collectedPokemon: cPokemon,
                  onTap: onCapturedTap,
                ),
              ),

              /// IMAGE
              Positioned(
                bottom: 0,
                right: 0,
                child: PokemonImage(pokemon: cPokemon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
