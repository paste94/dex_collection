import 'package:dex_collection/features/collection/details/provider/details_search_provider.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/main.dart';
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
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    // ref.read(detailsSearchProvider.notifier).state = '';
    controller.dispose();
    // ref.read(detailsSearchProvider.notifier).state = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchString = ref.watch(detailsSearchProvider);

    logger.d('searchString: ${searchString}');

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(90.0)),
        hintText: AppLocalizations.of(context)!.pokemon_details_search_hint,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Icon(Icons.search),
        ),
        suffixIcon: searchString.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => controller.clear(),
                ),
              )
            : null,
      ),
    );
  }
}
