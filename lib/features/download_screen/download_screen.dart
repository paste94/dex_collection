import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/PokeAPI/pokeapi_service.dart';
import 'package:dex_collection/main.dart' show logger;
import 'package:dex_collection/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        Navigator.of(context).pushReplacementNamed(ROUTES.home);
      }
    } catch (e) {
      setState(() {
        errorState =
            "Error fetching data, please check your internet connection and try again.";
      });
      logger.e("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  errorState ?? 'Downloading, please wait...',
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
                          child: Text('Retry'),
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
