import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChkSelectAll extends ConsumerWidget {
  final bool value;
  const ChkSelectAll({super.key, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleSelectAllChange(bool? value) {
      if (value == null) {
        return;
      }
      ref.read(pokemonListProvider.notifier).selectAllVisible(value);
    }

    return Checkbox(value: value, onChanged: handleSelectAllChange);
  }
}
