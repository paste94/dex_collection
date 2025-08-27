import 'package:cached_network_image/cached_network_image.dart';
import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/collection_list/widgets/svg_icon_with_halo.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/utility/common_funcions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListItem extends ConsumerWidget {
  final CollectedPokemon pokemon;
  final int imageSize = 150;
  const ListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Providers
    final collectionIndex = ref.watch(collectionIndexProvider)!;

    /// Functions
    Color? cardColorFromPokemon(CollectedPokemon pokemon) =>
        pokemon.isCaptured ? Color(pokemon.pokemon!.color ?? 0) : null;

    Color iconColorFromPokemon(CollectedPokemon pokemon) =>
        pokemon.isCaptured ? Colors.transparent : Colors.grey;

    String imageFromPokemon() => pokemon.isShiny ?? false
        ? pokemon.pokemon?.shinyImg ?? ''
        : pokemon.pokemon?.img ?? '';

    Color shinyIconColorFromPokemon() =>
        pokemon.isShiny ?? false ? Colors.yellow : Colors.black54;

    /// Handlers
    handleCardTap() => ref
        .read(collectionStateProvider.notifier)
        .togglePokemon(collectionIndex, pokemon.id);

    handleShiny() => ref
        .read(collectionStateProvider.notifier)
        .toggleShiny(collectionIndex, pokemon.id);

    return Card(
      color: cardColorFromPokemon(pokemon),
      // child: InkWell(
      //   onTap: handleCardTap,
      //   borderRadius: BorderRadius.circular(getCardCornerRadius(context)),
      //   child:
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name
                Text(
                  formatName(pokemon.pokemon!),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    // fontStyle: FontStyle.italic,
                  ),
                ),

                /// ID
                Text(
                  '#${pokemon.pokemon?.id.toString().padLeft(4, '0')}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),

                /// Image
                // Row(
                //   children: [
                //     Spacer(),
                //     ColorFiltered(
                //       colorFilter: ColorFilter.mode(
                //         iconColorFromPokemon(pokemon),
                //         BlendMode.srcATop,
                //       ),
                //       child: CachedNetworkImage(
                //         height: 130,
                //         width: 130,
                //         fit: BoxFit.fill,
                //         imageUrl: pokemon.pokemon?.img ?? '',
                //         placeholder: (context, url) => Padding(
                //           padding: const EdgeInsets.all(48.0),
                //           child: CircularProgressIndicator(),
                //         ),
                //         errorWidget: (context, url, error) => Icon(Icons.error),
                //       ),
                //     ),
                //   ],
                // ),

                // Text(pokemon.isCaptured ? 'CAPUTRED' : 'NOT CAPTURED'),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                iconColorFromPokemon(pokemon),
                BlendMode.srcATop,
              ),
              child: CachedNetworkImage(
                height: imageSize.toDouble(),
                width: imageSize.toDouble(),
                fit: BoxFit.fill,
                imageUrl: pokemon.pokemon?.img ?? '',
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),

          // Oggetto in alto a destra
          Positioned(
            top: 0,
            right: 0,
            // child: SvgIconWithHalo(
            //   asset: 'assets/icons/pokeball.svg',
            //   haloOpacity: 0,
            //   size: 8,
            // ),
            child: Row(
              children: [
                IconButton(
                  onPressed: handleShiny,
                  icon: SvgIconWithHalo(
                    asset: 'assets/icons/shiny.svg',
                    haloOpacity: 0,
                    size: 32,
                    iconColor: shinyIconColorFromPokemon(),
                  ),
                ),
                IconButton(
                  onPressed: handleCardTap,
                  icon: SvgIconWithHalo(
                    asset: 'assets/icons/pokeball.svg',
                    haloOpacity: 0,
                    size: 32,
                    iconColor: pokemon.isCaptured
                        ? Colors.black54
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            // child: Checkbox(
            //   value: pokemon.isCaptured,
            //   onChanged: (value) => handleCardTap(),
            // ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                iconColorFromPokemon(pokemon),
                BlendMode.srcATop,
              ),
              child: CachedNetworkImage(
                height: imageSize.toDouble(),
                width: imageSize.toDouble(),
                fit: BoxFit.fill,
                imageUrl: imageFromPokemon(),
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
