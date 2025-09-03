import 'package:dex_collection/features/collection/details/provider/details_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsSearchBar extends ConsumerStatefulWidget {
  const DetailsSearchBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailsSearchBarState();
}

class _DetailsSearchBarState extends ConsumerState<DetailsSearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.addListener(
      () => ref.read(detailsSearchProvider.notifier).state = controller.text,
    );
    return SearchBar(controller: controller);
  }
}
