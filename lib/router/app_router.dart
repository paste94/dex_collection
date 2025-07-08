import 'package:dex_collection/features/collection/details/colleciton_details_screen.dart';
import 'package:dex_collection/features/collection/create/create_collection_screen.dart';
import 'package:dex_collection/features/collection/list/collection_list_screen.dart';
import 'package:dex_collection/features/collection/search/search_screen.dart';
import 'package:dex_collection/features/settings/settings_view.dart';
import 'package:dex_collection/utility/router_observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Router Provider che può reagire allo stato
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    observers: [RouterObserver()],
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return CollectionListScreen();
        },
      ),

      GoRoute(
        path: '/create_collection',
        builder: (context, state) => CreateCollectionScreen(),
      ),
      GoRoute(
        path: '/collection/:index',
        builder: (context, state) {
          final index =
              state.pathParameters['index'] != null
                  ? int.tryParse(state.pathParameters['index']!)
                  : null;
          return CollectionDetailsScreen(index: index);
        },
        routes: [
          GoRoute(
            path: 'search',
            builder: (context, state) {
              final index =
                  state.pathParameters['index'] != null
                      ? int.tryParse(state.pathParameters['index']!)
                      : null;
              return SearchScreen(index: index);
            },
          ),
        ],
      ),
      GoRoute(path: '/settings', builder: (context, state) => SettingsView()),
    ],
  );
});
