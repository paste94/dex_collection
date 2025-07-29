import 'package:dex_collection/features/collection/edit_collection/provider/filter_variables.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnFilter extends ConsumerWidget {
  const BtnFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.filter_alt),
      onPressed:
          () => showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (context) {
              return Consumer(
                builder: (context, ref, _) {
                  final generations = ref.watch(generationsProvider);
                  return Column(
                    children: [
                      Text('Generation'),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          children:
                              generations
                                  .map(
                                    (gen) => ChoiceChip(
                                      label: Text(gen.name),
                                      selected: gen.isSelected,
                                      onSelected: (bool selected) {
                                        ref
                                            .read(generationsProvider.notifier)
                                            .select(gen, selected);
                                        ref
                                            .read(pokemonListProvider.notifier)
                                            .filter();
                                      },
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      Text('Regional'),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          children:
                              generations
                                  .map(
                                    (gen) => ChoiceChip(
                                      label: Text(gen.name),
                                      selected: gen.isSelected,
                                      onSelected: (bool selected) {
                                        ref
                                            .read(generationsProvider.notifier)
                                            .select(gen, selected);
                                        ref
                                            .read(pokemonListProvider.notifier)
                                            .filter();
                                      },
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
    );
  }
}
