import 'package:dex_collection/Hive/collection/collection_provider.dart';
import 'package:dex_collection/features/collection/list/widgets/collection_tile.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionListScreen extends ConsumerWidget {
  const CollectionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Collection> collectionList = ref.watch(collectionStateProvider);
    logger.i(
      '[collection_list_screen.dart] Collection list length: ${collectionList.length}',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Collections'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () async {
            //     final result = await context.push<String>('/search');
            //     if (result != null) {
            //       if (context.mounted) context.go('/', extra: result);
            //     }
            //   },
            //   child: Text('Vai alla ricerca'),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: collectionList.length,
                itemBuilder: (context, index) {
                  final item = collectionList[index];
                  // logger.i('[home_screen.dart] Collection item: ${item.name}');
                  return CollectionTile(index: index);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviga alla schermata di ricerca
          context.push('/create_collection');
        },
        tooltip: 'Add new collection',
        child: Icon(Icons.add),
      ),
    );
  }
}
