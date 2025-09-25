import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/PokeAPI/pokeapi_service.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/main.dart' show logger;
import 'package:dex_collection/router/const/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DownloadScreen extends ConsumerStatefulWidget {
  const DownloadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends ConsumerState<DownloadScreen> {
  String? errorState;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      final pokemonList = await PokeapiService.getAllPokemons();
      ref.read(dbPokemonProvider.notifier).addAllPokemons(pokemonList);
      if (mounted) {
        context.go(ROUTES.home);
      }
    } catch (e) {
      setState(() {
        errorState = AppLocalizations.of(context)!.fetch_error;
      });
      logger.e("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Icon(Icons.download, size: 64),
              Expanded(
                flex: 10,
                child: Image.asset(
                  errorState == null
                      ? 'assets/app/download.png'
                      : 'assets/app/no_connection.png',
                  height: 200, // altezza fissa
                  width: 200, // opzionale, se vuoi proporzioni
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  errorState ?? AppLocalizations.of(context)!.downloading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                flex: 1,
                child: Center(
                  child: errorState == null
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              errorState = null;
                            });
                            _fetchData();
                          },
                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                ),
              ),

              SizedBox(height: 250),
            ],
          ),
        ),
      ),
    );
  }
}
