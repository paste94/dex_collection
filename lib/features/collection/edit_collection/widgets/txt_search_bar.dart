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
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Icon(Icons.search),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(90.0)),
        suffixIcon: controller.text.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => controller.clear(),
                ),
              )
            : null,
      ),
    );
  }
}
