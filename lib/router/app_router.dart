import 'package:dex_collection/features/collection/details/colleciton_details_screen.dart';
import 'package:dex_collection/features/collection/collection_list/collection_list_screen.dart';
import 'package:dex_collection/features/collection/edit_collection/edit_collection_screen.dart';
import 'package:dex_collection/features/error_screen/error_screen.dart';
import 'package:dex_collection/features/settings/settings_view.dart';
import 'package:dex_collection/utility/router_observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ROUTES {
  static const String home = '/';
  static const String createCollection = '/create-collection';
  static const String collectionDetails = '/collection';
  static const String editCollection = '/collection/edit';
  static const String settings = '/settings';
  static const String error = '/error';
}

/// Router Provider che può reagire allo stato
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    observers: [RouterObserver()],
    routes: [
      GoRoute(
        path: ROUTES.home,
        builder: (context, state) {
          return CollectionListScreen();
        },
      ),

      GoRoute(
        path: ROUTES.createCollection,
        builder: (context, state) => EditCollectionScreen(),
      ),
      GoRoute(
        path: ROUTES.collectionDetails,
        // path: '/collection/:index',
        builder: (context, state) {
          // final index =
          //     state.pathParameters['index'] != null
          //         ? int.tryParse(state.pathParameters['index']!)
          //         : null;
          // return CollectionDetailsScreen(index: index);
          return CollectionDetailsScreen();
        },
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) {
              // final index =
              //     state.pathParameters['index'] != null
              //         ? int.tryParse(state.pathParameters['index']!)
              //         : null;
              // return SearchScreen(index: index);
              return EditCollectionScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: ROUTES.settings,
        builder: (context, state) => SettingsView(),
      ),
      GoRoute(path: ROUTES.error, builder: (context, state) => ErrorScreen()),
    ],
  );
});
