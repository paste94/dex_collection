// import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class UndoSnackbar extends ConsumerWidget with SnackBar {
//   final String name;
//   final String id;
//   const UndoSnackbar({super.key, required this.name, required this.id});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SnackBar(
//       content: Text('Collection $name deleted'),
//       action: SnackBarAction(
//         label: 'Undo',
//         onPressed: () {
//           ref.read(collectionListProvider.notifier).hideCollectionById(id);
//         },
//       ),
//     );
//   }
// }
