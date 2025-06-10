import 'package:dex_collection/Hive/collection/collection_provider.dart';
import 'package:dex_collection/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionTile extends ConsumerWidget {
  final int index;
  const CollectionTile({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Collection item = ref.watch(collectionStateProvider)[index];
    return GestureDetector(
      onTap: () => context.push('/collection/$index', extra: index),
      child: Card.outlined(
        color: Color(item.color),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 24.0,
            bottom: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name ?? 'NONE',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
