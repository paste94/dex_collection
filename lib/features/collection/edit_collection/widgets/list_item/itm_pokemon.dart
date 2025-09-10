import 'package:cached_network_image/cached_network_image.dart';
import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/list_item/widgets/icn_selected.dart';
import 'package:dex_collection/utility/common_funcions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemPokemon extends ConsumerWidget {
  final UISearchModel<Pokemon> uiPokemon;
  const ItemPokemon({super.key, required this.uiPokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 90,
      child: Card.outlined(
        // color: Color(
        //   uiPokemon.item.color ?? 0,
        // ).withAlpha(uiPokemon.isSelected ? 255 : 180),
        child: InkWell(
          onTap: () => ref.read(pokemonListProvider.notifier).toggle(uiPokemon),
          borderRadius: BorderRadius.circular(getCardCornerRadius(context)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: uiPokemon.item.img ?? '',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Text(formatName(uiPokemon.item)),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IcnSelected(uiPokemon: uiPokemon),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
