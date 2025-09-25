import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DialogEditId extends ConsumerStatefulWidget {
  final CollectedPokemon cPokemon;
  const DialogEditId({super.key, required this.cPokemon});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DialogEditIdState();
}

class _DialogEditIdState extends ConsumerState<DialogEditId> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.cPokemon.customId ?? "");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.edit_id_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.new_id_label,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              String? collectionId = ref.watch(collectionIdProvider)!;
              ref
                  .read(collectionListProvider.notifier)
                  .updateCustomId(
                    collectionId,
                    widget.cPokemon.id,
                    controller.text,
                  );
            });
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    );
  }
}
