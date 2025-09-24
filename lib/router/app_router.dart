import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/features/collection/details/colleciton_details_screen.dart';
import 'package:dex_collection/features/collection/collection_list/collection_list_screen.dart';
import 'package:dex_collection/features/collection/edit_collection/edit_collection_screen.dart';
import 'package:dex_collection/features/download_screen/download_screen.dart';
import 'package:dex_collection/features/error_screen/error_screen.dart';
import 'package:dex_collection/features/about/about_screen.dart';
import 'package:dex_collection/features/settings/settings_view.dart';
import 'package:dex_collection/main.dart';
import 'package:dex_collection/router/const/routes.dart' show ROUTES;
import 'package:dex_collection/router/go_router_refresh_notifier.dart';
import 'package:dex_collection/router/router_observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Router Provider che può reagire allo stato
final routerProvider = Provider<GoRouter>((ref) {
  final dbPokemon = GoRouterRefreshNotifier(ref);
  return GoRouter(
    observers: [RouterObserver()],
    refreshListenable: dbPokemon,
    routes: [
      GoRoute(path: ROUTES.home, builder: (_, __) => CollectionListScreen()),

      GoRoute(
        path: ROUTES.createCollection,
        builder: (_, __) => EditCollectionScreen(),
      ),

      GoRoute(
        path: ROUTES.collectionDetails,
        builder: (_, __) => CollectionDetailsScreen(),
        routes: [
          GoRoute(path: 'edit', builder: (_, __) => EditCollectionScreen()),
        ],
      ),

      GoRoute(path: ROUTES.settings, builder: (_, __) => SettingsView()),

      GoRoute(path: ROUTES.download, builder: (_, __) => DownloadScreen()),

      GoRoute(path: ROUTES.about, builder: (_, __) => AboutScreen()),

      GoRoute(path: ROUTES.error, builder: (_, __) => ErrorScreen()),
    ],

    errorBuilder: (_, state) => ErrorScreen(message: state.error.toString()),

    redirect: (_, state) {
      logger.i('REDIRECT: ${state.fullPath}');
      final db = ref.read(dbPokemonProvider);
      if (db.isEmpty) {
        logger.w("No pokemon in database");
        return ROUTES.download;
      }
      return null;
    },
  );
});
