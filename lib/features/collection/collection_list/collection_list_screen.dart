import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/collection_list/const/scaffold_actions.dart';
import 'package:dex_collection/features/collection/collection_list/widgets/collection_tile.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionListScreen extends ConsumerStatefulWidget {
  const CollectionListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionListScreenState();
}

class _CollectionListScreenState extends ConsumerState<CollectionListScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Collection> collectionList = ref.watch(collectionListProvider);
    final List<Collection> collectionListToShow =
        collectionList
            .where((collection) => collection.isHidden != true)
            .toList()
          ..sort((a, b) {
            if (a.order == null && b.order == null) return 0;
            if (a.order == null) return 1; // a è "più grande"
            if (b.order == null) return -1; // b è "più grande"
            return a.order!.compareTo(b.order!);
          });

    return Scaffold(
      appBar: AppBar(
        title: Text('Collections'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: context.push,
            itemBuilder: (BuildContext context) {
              return SCAFFOLD_ACTIONS
                  .map(
                    (e) => PopupMenuItem<String>(
                      value: e['route'] as String,
                      child: Row(
                        children: [
                          Icon(e['icon'] as IconData),
                          SizedBox(width: 8),
                          Text(e['name'] as String),
                        ],
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: collectionListToShow.isNotEmpty
            ? ReorderableListView.builder(
                itemBuilder: (context, index) {
                  final item = collectionListToShow[index];
                  return Container(
                    key: Key('$index'),
                    child: CollectionTile(collection: item),
                  );
                },
                itemCount: collectionListToShow.length,
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) newIndex--;
                  // logger.d('OLD INDEX: $oldIndex\nNEW INDEX: $newIndex');
                  final item = collectionListToShow.removeAt(oldIndex);
                  collectionListToShow.insert(newIndex, item);

                  Map<String, int> idIndexMap = {};

                  for (int i = 0; i < collectionListToShow.length; i++) {
                    idIndexMap[collectionListToShow[i].id] = i;
                  }

                  ref
                      .read(collectionListProvider.notifier)
                      .updateOrder(idIndexMap);
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/app/no_data.png',
                      height: 200, // altezza fissa
                      width: 200, // opzionale, se vuoi proporzioni
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.no_collections_yet,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviga alla schermata di ricerca
          context.push('/create-collection');
        },
        tooltip: AppLocalizations.of(context)!.new_collection_tooltip,
        child: Icon(Icons.add),
      ),
    );
  }
}
