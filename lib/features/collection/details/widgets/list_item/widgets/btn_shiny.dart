import 'package:dex_collection/features/collection/collection_list/widgets/svg_icon_with_halo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnShiny extends ConsumerWidget {
  final bool isShiny;
  final Function() onTap;
  const BtnShiny({super.key, required this.isShiny, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final collectionIndex = ref.watch(collectionIndexProvider)!;
    colorFromShiny() => isShiny ? Colors.yellow : Colors.black54;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, anim) => RotationTransition(
        turns: child.key == ValueKey(Colors.black54)
            ? Tween<double>(begin: 0, end: 1).animate(anim)
            : Tween<double>(begin: 1, end: 0).animate(anim),
        child: ScaleTransition(scale: anim, child: child),
      ),
      child: IconButton(
        key: ValueKey<Color>(colorFromShiny()),
        onPressed: onTap,
        icon: SvgIconWithHalo(
          asset: 'assets/icons/shiny.svg',
          haloOpacity: 0,
          size: 32,
          iconColor: colorFromShiny(),
        ),
      ),
    );
  }
}
