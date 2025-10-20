import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/features/collection/collection_list/widgets/svg_icon_with_halo.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/router/app_router.dart';
import 'package:dex_collection/router/const/routes.dart';
import 'package:dex_collection/utility/common_funcions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CollectionTile extends ConsumerWidget {
  // final int index;
  final Collection collection;
  const CollectionTile({
    super.key,
    // required this.index,
    required this.collection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card.outlined(
      key: Key(collection.id),
      color: Color(collection.color),
      child: ClipRRect(
        child: Stack(
          children: [
            // Pattern di sfondo
            Positioned.fill(
              child: Opacity(
                opacity: 0.20, // molto leggero
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  child: Transform.translate(
                    offset: Offset(100, 0),
                    child: Transform.scale(
                      scale: 0.7,
                      child: Transform.rotate(
                        angle: -0.3,
                        child: SvgPicture.asset(
                          'assets/icons/pokeball.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ref.read(collectionIdProvider.notifier).state = collection.id;
                context.push(ROUTES.collectionDetails);
              },
              borderRadius: BorderRadius.circular(getCardCornerRadius(context)),

              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 24.0,
                  bottom: 24.0,
                ),
                child: Row(
                  children: [
                    SvgIconWithHalo(
                      asset: 'assets/icons/pokedex.svg',
                      size: 50, // piccolo cerchiolino
                      haloOpacity: 0.0, // leggermente scuro e semi-trasparente
                      iconColor: Colors.black54,
                    ),
                    SizedBox(width: 16),
                    Text(
                      collection.name ?? 'NONE',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Spacer(),
                    // Text('${collection.order} - '),
                    Text(
                      '${collection.pokemons?.where((pokemon) => pokemon.isCaptured).length}/${collection.pokemons?.length ?? 0}',
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
