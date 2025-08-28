import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/collection_list/widgets/collection_tile.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/main.dart';
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
    final List<Collection> collectionList = ref.watch(collectionStateProvider);
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
        actions: [
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView.builder(
                itemBuilder: (context, index) {
                  final item = collectionListToShow[index];
                  // return Card(
                  //   key: Key('$index'),
                  //   // title: Text('Item ${collectionListToShow[index].name}'),
                  // );
                  return Container(
                    key: Key('$index'),
                    child: CollectionTile(collection: item),
                  );
                },
                itemCount: collectionListToShow.length,
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) newIndex--;
                  logger.d('OLD INDEX: $oldIndex\nNEW INDEX: $newIndex');
                  final item = collectionListToShow.removeAt(oldIndex);
                  collectionListToShow.insert(newIndex, item);

                  Map<String, int> idIndexMap = {};

                  // collectionListToShow.asMap().map()

                  for (int i = 0; i < collectionListToShow.length; i++) {
                    idIndexMap[collectionListToShow[i].id] = i;
                  }

                  ref
                      .read(collectionStateProvider.notifier)
                      .updateOrder(idIndexMap);
                },
              ),
              // child: ListView.builder(
              //   itemCount: collectionListToShow.length,
              //   itemBuilder: (context, index) {
              //     final item = collectionListToShow[index];
              //     return CollectionTile(index: index, item: item);
              //   },
              // ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviga alla schermata di ricerca
          context.push('/create-collection');
          // context.push('/search');
        },
        tooltip: 'Add new collection',
        child: Icon(Icons.add),
      ),
    );
  }
}
