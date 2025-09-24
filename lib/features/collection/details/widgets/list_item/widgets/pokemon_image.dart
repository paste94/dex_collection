import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/utility/widgets/retry_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonImage extends ConsumerWidget {
  final CollectedPokemon pokemon;
  final int imageSize = 135;

  const PokemonImage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// COLOR FUNTIONS
    Color iconColorFromPokemon() =>
        pokemon.isCaptured ? Colors.transparent : Colors.grey;

    String imageFromPokemon() => pokemon.isShiny ?? false
        ? pokemon.pokemon?.shinyImg ?? ''
        : pokemon.pokemon?.img ?? '';

    logger.d('Image URL: ${imageFromPokemon()}');

    return ColorFiltered(
      colorFilter: ColorFilter.mode(iconColorFromPokemon(), BlendMode.srcATop),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 350),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: RetryCachedNetworkImage(
          key: ValueKey<String>(imageFromPokemon()),
          height: imageSize.toDouble(),
          width: imageSize.toDouble(),
          fit: BoxFit.fill,
          imageUrl: imageFromPokemon(),
          placeholder: (context, url) => Padding(
            padding: const EdgeInsets.all(48.0),
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) {
            return Icon(Icons.error);
          },
        ),
      ),
    );
  }
}
