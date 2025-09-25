import 'package:dex_collection/features/collection/edit_collection/widgets/filter/gen_filter.dart';
import 'package:dex_collection/features/collection/edit_collection/widgets/filter/reg_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnFilter extends ConsumerWidget {
  const BtnFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.filter_alt),
      onPressed: () => showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) {
          return Consumer(
            builder: (context, ref, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [GenFilter(), RegFilter()],
              );
            },
          );
        },
      ),
    );
  }
}
