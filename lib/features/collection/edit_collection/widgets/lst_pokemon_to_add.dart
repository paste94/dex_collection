import 'package:cached_network_image/cached_network_image.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:dex_collection/utility/common_funcions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LstPokemonToAdd extends ConsumerWidget {
  final List<UISearchModel<Pokemon>> visibleItems;
  // final Function(UISearchModel<Pokemon>) toggle;
  const LstPokemonToAdd({
    super.key,
    required this.visibleItems,
    // required this.toggle,
  });

  // String formatName(Pokemon pokemon) {
  //   final formattedName = pokemon.name
  //       // .replaceAll('-', ' ')
  //       .replaceAll('-alola', ' Alola')
  //       .replaceAll('-galar', ' Galar')
  //       .replaceAll('-hisui', ' Hisui')
  //       .replaceAll('-paldea', ' Paldea')
  //       .replaceAllMapped(
  //         RegExp(r'(^\w|\s\w)'),
  //         (match) => match.group(0)!.toUpperCase(),
  //       );
  //   return '# ${pokemon.id} - $formattedName';
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: visibleItems.length,
      itemBuilder: (context, index) {
        final pokemon = visibleItems[index];
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: pokemon.item.img ?? '',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          title: Text('#${pokemon.item.id} - ${formatName(pokemon.item)}'),
          subtitle: Text(pokemon.item.name),
          trailing: pokemon.isSelected
              ? Icon(Icons.check_circle, color: Colors.green)
              : Icon(Icons.circle_outlined),
          onTap: () => ref.read(pokemonListProvider.notifier).toggle(pokemon),
        );
      },
    );
  }
}
