import 'package:dex_collection/features/collection/details/colleciton_details_screen.dart';
import 'package:dex_collection/features/collection/create/create_collection_screen.dart';
import 'package:dex_collection/features/collection/list/collection_list_screen.dart';
import 'package:dex_collection/features/search/search_screen.dart';
import 'package:dex_collection/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Router Provider che può reagire allo stato
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return CollectionListScreen();
        },
      ),
      GoRoute(path: '/search', builder: (context, state) => SearchScreen()),
      GoRoute(
        path: '/create_collection',
        builder: (context, state) => CreateCollectionScreen(),
      ),
      GoRoute(
        path: '/collection/:index',
        builder: (context, state) {
          logger.i(
            '[app_router.dart] Navigating to collection details with index: ${state.pathParameters['index']}',
          );
          final index =
              state.pathParameters['index'] != null
                  ? int.tryParse(state.pathParameters['index']!)
                  : null;
          return CollectionDetailsScreen(index: index!);
        },
      ),
    ],
  );
});
