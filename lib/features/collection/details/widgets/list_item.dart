import 'package:cached_network_image/cached_network_image.dart';
import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListItem extends ConsumerWidget {
  final PokemonCollection pokemon;
  const ListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        pokemon.pokemon?.name ?? AppLocalizations.of(context)!.unknown_pokemon,
      ),
      leading: CachedNetworkImage(
        imageUrl: pokemon.pokemon?.img ?? '',
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      onTap: () {
        // Naviga alla schermata di dettaglio del Pokémon
      },
    );
  }
}
