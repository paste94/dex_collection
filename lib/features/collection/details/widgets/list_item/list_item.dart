import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item/widgets/btn_captured.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item/widgets/btn_shiny.dart';
import 'package:dex_collection/features/collection/details/widgets/list_item/widgets/pokemon_image.dart';
import 'package:dex_collection/utility/common_funcions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListItem extends ConsumerWidget {
  final CollectedPokemon pokemon;
  const ListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Providers
    // final collectionIndex = ref.watch(collectionIndexProvider)!;
    String? collectionId = ref.watch(collectionIdProvider)!;

    /// Functions
    Color? cardColorFromPokemon() => pokemon.isCaptured
        ? Color(pokemon.pokemon!.color ?? 0)
        : Theme.of(context).cardTheme.color;

    /// Handlers
    onCapturedTap() => ref
        .read(collectionListProvider.notifier)
        .toggleCaptured(collectionId, pokemon.id);

    onShinyTap() => ref
        .read(collectionListProvider.notifier)
        .toggleShiny(collectionId, pokemon.id);

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: Card(
        // key: ValueKey<String>  (cardColorFromPokemon().toString()),
        color: cardColorFromPokemon(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAME
                  Text(
                    formatName(pokemon.pokemon!),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  /// ID
                  Text(
                    '#${pokemon.pokemon?.id.toString().padLeft(4, '0')}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
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
                isShiny: pokemon.isShiny ?? false,
                onTap: onShinyTap,
              ),
            ),

            /// BTN CAPTURED
            Positioned(
              top: 0,
              right: 0,
              child: BtnCaptured(
                collectedPokemon: pokemon,
                onTap: onCapturedTap,
              ),
            ),

            /// IMAGE
            Positioned(
              bottom: 0,
              right: 0,
              child: PokemonImage(pokemon: pokemon),
            ),
          ],
        ),
      ),
    );
  }
}
