import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/features/collection/details/widgets/details_grid_view.dart';
import 'package:dex_collection/features/collection/details/widgets/dialog_edit_id.dart';
import 'package:dex_collection/features/collection/details/widgets/txt_search_bar.dart';
import 'package:dex_collection/features/error_screen/error_screen.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionDetailsScreen extends ConsumerStatefulWidget {
  const CollectionDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState
    extends ConsumerState<CollectionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final collectionId = ref.watch(collectionIdProvider);
    if (collectionId == null) {
      return ErrorScreen();
    }

    final Collection collection = ref
        .watch(collectionListProvider)
        .where((element) => element.id == collectionId)
        .first;

    handleEdit() => context.push(ROUTES.editCollection);
    handleDelete() {
      final collectionNotifier = ref.read(collectionListProvider.notifier);

      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text('Collections ${collection.name} deleted'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  collectionNotifier.unhideCollectionById(collection.id);
                },
              ),
            ),
          )
          .closed
          .then((value) {
            collectionNotifier.deleteHiddenCollections();
          });

      collectionNotifier.hideCollectionById(collection.id);
      context.pop();
    }

    handleEditIDs() {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.edit_ids,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 16),
                Text(
                  'Feature not implemented yet',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (context, result) {
        Future.delayed(
          Duration(milliseconds: 100),
          () => ref.read(collectionIdProvider.notifier).state = null,
        );
      },
      // canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${collection.name}'),
          backgroundColor: Color(collection.color),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    onTap: handleEdit,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.edit),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: handleEditIDs,
                    child: Row(
                      children: [
                        Icon(Icons.numbers),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.edit_ids),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: handleDelete,
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.delete),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TxtSearchBar(),
              SizedBox(height: 8),
              Expanded(child: DetailsGridView()),
            ],
          ),
        ),
      ),
    );
  }
}
