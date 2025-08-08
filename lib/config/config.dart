// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

const int POKEMON_LIMIT = 10;

/// Allowed form list
const List<String> REGIONAL_FORMS = ['alola', 'galar', 'hisui', 'paldea'];

/// List of not allowed forms (from the allowed set)
const List<String> NON_VALID_REGIONAL_FORM = ['totem', 'cap'];

/// List of allowed colors
final Map<String, Color> POKEAPI_COLORS = {
  'black': Colors.black,
  'blue': Colors.blue.shade300,
  'brown': Colors.brown.shade300,
  'gray': Colors.black54,
  'green': Colors.green.shade300,
  'pink': Colors.pink.shade300,
  'purple': Colors.purple.shade300,
  'red': Colors.red.shade300,
  'white': Colors.white,
  'yellow': Colors.yellow.shade300,
};
