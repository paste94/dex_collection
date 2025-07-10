import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TxtSearchBar extends ConsumerWidget {
  final TextEditingController controller;

  const TxtSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.pokemon_search_hint,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        suffixIcon:
            controller.text.isNotEmpty
                ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                  },
                )
                : null,
      ),
    );
  }
}
