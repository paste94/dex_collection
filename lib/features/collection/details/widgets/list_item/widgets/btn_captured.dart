import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/features/collection/collection_list/widgets/svg_icon_with_halo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnCaptured extends ConsumerWidget {
  // final bool isCaptured;
  final CollectedPokemon collectedPokemon;
  final Function() onTap;
  const BtnCaptured({
    super.key,
    required this.collectedPokemon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // color() => isCaptured ? Colors.black54 : Colors.grey;

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 350),
      transitionBuilder: (child, anim) => RotationTransition(
        // turns: child.key == ValueKey('true')
        turns: collectedPokemon.isCaptured == true
            ? Tween<double>(begin: 0, end: 1).animate(anim)
            : Tween<double>(begin: 1, end: 0).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      ),
      child: IconButton(
        key: ValueKey<String>(collectedPokemon.isCaptured.toString()),
        onPressed: onTap,
        icon: SvgIconWithHalo(
          asset: collectedPokemon.isCaptured
              ? 'assets/icons/pokeball_colored.svg'
              : 'assets/icons/pokeball.svg',
          haloOpacity: 0,
          size: 32,
        ),
      ),
    );
  }
}
