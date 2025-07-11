import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/features/collection/list/widgets/collection_tile.dart';
import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/router/app_router.dart';
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
            .toList();

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
              child: ListView.builder(
                itemCount: collectionListToShow.length,
                itemBuilder: (context, index) {
                  final item = collectionListToShow[index];
                  return CollectionTile(index: index, item: item);
                },
              ),
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
