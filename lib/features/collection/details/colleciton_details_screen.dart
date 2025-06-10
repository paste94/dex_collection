import 'package:dex_collection/Hive/collection/collection_provider.dart';
import 'package:dex_collection/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionDetailsScreen extends ConsumerWidget {
  int index;
  CollectionDetailsScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Collection item = ref.watch(collectionStateProvider)[index];
    return Scaffold(
      appBar: AppBar(title: Text('Details for Item ${item.name}')),
      body: Center(
        child: Text('Displaying details for item with index: $index'),
      ),
    );
  }
}
