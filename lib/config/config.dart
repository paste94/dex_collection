// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

const int POKEMON_LIMIT = 2000;

/// Allowed form list
const List<String> REGIONAL_FORMS = ['alola', 'galar', 'hisui', 'paldea'];

/// List of not allowed forms (from the allowed set)
const List<String> NON_VALID_REGIONAL_FORM = ['totem', 'cap'];

/// List of allowed colors
final Map<String, Color> POKEAPI_COLORS = {
  'black': Colors.blueGrey,
  'blue': Colors.blue.shade300,
  'brown': Colors.brown.shade300,
  'gray': Colors.grey,
  'green': Colors.green.shade300,
  'pink': Colors.pink.shade300,
  'purple': Colors.purple.shade300,
  'red': Colors.red.shade300,
  'white': Colors.amber[50]!,
  'yellow': Colors.yellow.shade300,
};

const GITHUB_USERNAME = "paste94";
const GITHUB_REPO = "dex_collector_downloader";
const ASSET_NAME = "pokemon_list.json";
const URL_REPO_DOWNLOAD =
    "https://api.github.com/repos/$GITHUB_USERNAME/$GITHUB_REPO/releases/latest";
const GITHUB_ULR = 'https://github.com/paste94/dex_collection';
const PAYPAL_DONATION_URL = 'https://paypal.me/riccardopasteris';
