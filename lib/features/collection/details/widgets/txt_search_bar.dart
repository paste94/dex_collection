import 'package:dex_collection/features/collection/details/provider/details_search_provider.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TxtSearchBar extends ConsumerStatefulWidget {
  const TxtSearchBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TxtSearchBarState();
}

class _TxtSearchBarState extends ConsumerState<TxtSearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(
      () => ref.read(detailsSearchProvider.notifier).state = controller.text,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchString = ref.watch(detailsSearchProvider);

    return SearchBar(
      controller: controller,
      leading: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Icon(Icons.search),
      ),
      trailing: [
        searchString.isEmpty
            ? SizedBox.shrink()
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => controller.clear(),
              ),
      ],
      hintText: AppLocalizations.of(context)!.pokemon_details_search_hint,
    );
  }
}
