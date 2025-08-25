import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:dex_collection/config/config.dart';
import 'package:flutter/material.dart';

double getCardCornerRadius(context) {
  final cardTheme = Theme.of(context).cardTheme;
  final shape = cardTheme.shape;

  if (shape is RoundedRectangleBorder) {
    final br = shape.borderRadius;
    if (br is BorderRadius) {
      return br.topLeft.x; // tutti i lati dovrebbero avere lo stesso valore
    }
  }

  // Ritorna il valore predefinito se `shape` è nullo o non è RoundedRectangleBorder
  return Theme.of(context).useMaterial3 ? 12.0 : 4.0;
}

String formatName(Pokemon pokemon) {
  var formattedName = pokemon.name;

  for (var form in REGIONAL_FORMS) {
    formattedName = formattedName.replaceAll('-$form', ' $form');
  }
  formattedName = formattedName.replaceAllMapped(
    RegExp(r'(^\w|\s\w)'),
    (match) => match.group(0)!.toUpperCase(),
  );
  return formattedName;
}
