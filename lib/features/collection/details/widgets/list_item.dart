import 'package:cached_network_image/cached_network_image.dart';
import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/utility/common_funcions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListItem extends ConsumerWidget {
  final CollectedPokemon pokemon;
  const ListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionIndex = ref.watch(collectionIndexProvider)!;

    return Card(
      color: pokemon.isCaptured ? Color(pokemon.pokemon!.color ?? 0) : null,
      child: InkWell(
        onTap: () {
          ref
              .read(collectionStateProvider.notifier)
              .togglePokemon(collectionIndex, pokemon.id);
        },
        borderRadius: BorderRadius.circular(getCardCornerRadius(context)),

        child: Column(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                pokemon.isCaptured ? Colors.transparent : Colors.grey,
                BlendMode.srcATop,
              ),
              child: CachedNetworkImage(
                imageUrl: pokemon.pokemon?.img ?? '',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(formatName(pokemon.pokemon!)),
            Text(pokemon.isCaptured ? 'CAPUTRED' : 'NOT CAPTURED'),
          ],
        ),
      ),
    );

    // return ListTile(
    //   title: Text(
    //     pokemon.pokemon?.name ?? AppLocalizations.of(context)!.unknown_pokemon,
    //   ),
    //   subtitle: Text(pokemon.isCaptured.toString()),
    //   leading: CachedNetworkImage(
    //     imageUrl: pokemon.pokemon?.img ?? '',
    //     placeholder: (context, url) => CircularProgressIndicator(),
    //     errorWidget: (context, url, error) => Icon(Icons.error),
    //   ),
    //   onTap: () {
    //     ref
    //         .read(collectionStateProvider.notifier)
    //         .togglePokemon(collectionIndex, pokemon.id);
    //     // Naviga alla schermata di dettaglio del Pokémon
    //   },
    // );
  }
}
