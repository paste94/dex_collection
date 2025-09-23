import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(this.ref) {
    ref.listen(dbPokemonProvider, (_, __) => notifyListeners());
  }
  final Ref ref;
}
