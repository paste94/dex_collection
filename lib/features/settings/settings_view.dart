import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final sectionStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings_title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      AppLocalizations.of(context)!.settings_database_section,
                      style: sectionStyle,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ListTile(
                    leading: const Icon(Icons.update),
                    title: Text(
                      AppLocalizations.of(context)!.settings_download_new_db,
                    ),
                    onTap: () =>
                        ref.read(dbPokemonProvider.notifier).clearCollection(),
                  ),

                  // ListTile(
                  //   leading: const Icon(Icons.delete),
                  //   title: const Text('Cancella database esistente'),
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => Dialog(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(16.0),
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               const Text(
                  //                 'Sei sicuro di voler cancellare il database esistente?',
                  //               ),
                  //               const SizedBox(height: 16),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 children: [
                  //                   TextButton(
                  //                     onPressed: () =>
                  //                         Navigator.of(context).pop(),
                  //                     child: const Text('Annulla'),
                  //                   ),
                  //                   TextButton(
                  //                     onPressed: () {
                  //                       try {
                  //                         ref
                  //                             .read(dbPokemonProvider.notifier)
                  //                             .clearCollection();
                  //                         ref
                  //                             .read(
                  //                               collectionListProvider.notifier,
                  //                             )
                  //                             .clearCollection();
                  //                         ScaffoldMessenger.of(
                  //                           context,
                  //                         ).showSnackBar(
                  //                           SnackBar(
                  //                             content: Text(
                  //                               'DB Deleted correctly',
                  //                             ),
                  //                           ),
                  //                         );
                  //                       } catch (e) {
                  //                         ScaffoldMessenger.of(
                  //                           context,
                  //                         ).showSnackBar(
                  //                           SnackBar(
                  //                             content: Text(
                  //                               'Error clearing data: $e',
                  //                             ),
                  //                           ),
                  //                         );
                  //                         logger.e("Error clearing data: $e");
                  //                       } finally {
                  //                         Navigator.of(context).pop();
                  //                       }
                  //                     },
                  //                     child: const Text('Conferma'),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
