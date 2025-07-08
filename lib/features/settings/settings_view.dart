import 'package:dex_collection/Hive/collection/provider/collection_provider.dart';
import 'package:dex_collection/Hive/pokemon/provider/db_pokemon_provider.dart';
import 'package:dex_collection/PokeAPI/pokeapi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView>
    with TickerProviderStateMixin {
  double _progress = 0.0;
  bool _isDownloading = false;

  void progressCallback(double progress) =>
      setState(() => _progress = progress);

  void downloadPokemon() async {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
    });
    final pokemonList = await PokeapiService.getAllPokemons(
      progressCalback: progressCallback,
    );
    ref.read(dbPokemonProvider.notifier).addAllPokemons(pokemonList);
    setState(() {
      _isDownloading = false;
      _progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sectionStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Database', style: sectionStyle),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.update),
                    title: const Text('Aggiorna database Pokémon'),
                    trailing: Text(
                      _progress > 0
                          ? '${(_progress * 100).toStringAsFixed(0)}%'
                          : '',
                    ),
                    onTap: downloadPokemon,
                  ),

                  _isDownloading
                      ? LinearProgressIndicator(value: _progress)
                      : const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Divider(height: 0),
                      ),

                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Cancella database esistente'),
                    onTap: () {
                      ref.read(dbPokemonProvider.notifier).clearCollection();
                      ref
                          .read(collectionStateProvider.notifier)
                          .clearCollection();
                      // TODO: implement delete database logic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
