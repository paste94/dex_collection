import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/ui_search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IcnSelected extends ConsumerWidget {
  final UISearchModel<Pokemon> uiPokemon;
  const IcnSelected({super.key, required this.uiPokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return uiPokemon.isSelected
        ? Icon(Icons.check_circle, color: Colors.black54)
        : Icon(Icons.circle_outlined, color: Colors.black54);
  }
}
