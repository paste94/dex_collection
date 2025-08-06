import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/region_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/region_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegFilter extends ConsumerWidget {
  const RegFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regions = ref.watch(regionFilterProvider);

    void handleRegionTap(Region reg, bool selected) {
      ref.read(regionFilterProvider.notifier).select(reg, selected);
      ref.read(pokemonListProvider.notifier).filter();
    }

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Region',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            SizedBox(height: 12),
            GridView.count(
              // Numero di colonne
              crossAxisCount: 3,
              // Fa sì che la griglia non occupi spazio infinito
              shrinkWrap: true,
              // Disabilita lo scroll interno
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              // Larghezza vs altezza del chip
              childAspectRatio: 3,
              children:
                  regions
                      .map(
                        (reg) => ChoiceChip(
                          label: Text(reg.name),
                          selected: reg.isSelected,
                          onSelected:
                              (selected) => handleRegionTap(reg, selected),
                        ),
                      )
                      .toList(),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
