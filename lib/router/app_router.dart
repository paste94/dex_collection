import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/details/colleciton_details_screen.dart';
import 'package:dex_collection/features/collection/collection_list/collection_list_screen.dart';
import 'package:dex_collection/features/collection/edit_collection/edit_collection_screen.dart';
import 'package:dex_collection/features/collection/edit_collection/provider/pokemon_list.dart';
import 'package:dex_collection/features/download_screen/download_screen.dart';
import 'package:dex_collection/features/error_screen/error_screen.dart';
import 'package:dex_collection/features/settings/settings_view.dart';
import 'package:dex_collection/main.dart';
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
  static const String download = '/download';
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
        builder: (context, state) {
          return CollectionDetailsScreen();
        },
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) {
              return EditCollectionScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: ROUTES.settings,
        builder: (context, state) => SettingsView(),
      ),
      GoRoute(
        path: ROUTES.download,
        builder: (context, state) => DownloadScreen(),
      ),
      GoRoute(path: ROUTES.error, builder: (context, state) => ErrorScreen()),
    ],
    errorBuilder: (context, state) =>
        ErrorScreen(message: state.error.toString()),
    redirect: (context, state) {
      if (ref.read(dbPokemonProvider).isEmpty &&
          state.fullPath != ROUTES.download) {
        logger.w("No pokemon in database");
        return ROUTES.download;
      }
      return state.fullPath;
    },
  );
});
