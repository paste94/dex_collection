import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TxtCollectionName extends ConsumerWidget {
  final TextEditingController controller;

  const TxtCollectionName({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.edit_collection_name_hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(90.0)),
      ),
    );
  }
}
