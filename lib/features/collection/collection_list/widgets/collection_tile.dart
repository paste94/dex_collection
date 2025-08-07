import 'package:dex_collection/Hive/collection/model/collection.dart';
import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionTile extends ConsumerWidget {
  final int index;
  final Collection item;
  const CollectionTile({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(collectionIndexProvider.notifier).state = index;
        context.push(ROUTES.collectionDetails);
      },
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
                "${item.name ?? 'NONE'} - ${item.isHidden ?? 'NONE'}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
