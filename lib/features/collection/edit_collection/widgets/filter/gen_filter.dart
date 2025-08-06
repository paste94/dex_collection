import 'package:dex_collection/features/collection/edit_collection/provider/UIModel/generation_model.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/generation_filter_provider.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenFilter extends ConsumerWidget {
  const GenFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generations = ref.watch(generationFilterProvider);

    void handleGenerationTap(Generation gen, bool selected) {
      ref.read(generationFilterProvider.notifier).select(gen, selected);
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
                  'Generation',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            SizedBox(height: 12),
            GridView.count(
              // Numero di colonne
              crossAxisCount: 2,
              // Fa sì che la griglia non occupi spazio infinito
              shrinkWrap: true,
              // Disabilita lo scroll interno
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              // Larghezza vs altezza del chip
              childAspectRatio: 4,
              children:
                  generations
                      .map(
                        (gen) => ChoiceChip(
                          label: Text(gen.name),
                          selected: gen.isSelected,
                          onSelected:
                              (selected) => handleGenerationTap(gen, selected),
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
