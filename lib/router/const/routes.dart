// ignore_for_file: non_constant_identifier_names

import 'package:dex_collection/features/collection/collection_list/collection_list_screen.dart';
import 'package:dex_collection/features/collection/details/colleciton_details_screen.dart';
import 'package:dex_collection/features/collection/edit_collection/edit_collection_screen.dart';
import 'package:dex_collection/features/download_screen/download_screen.dart';
import 'package:dex_collection/features/error_screen/error_screen.dart';
import 'package:dex_collection/features/about/about_screen.dart';
import 'package:dex_collection/features/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ROUTES {
  static const String home = '/';
  static const String createCollection = '/create-collection';
  static const String collectionDetails = '/collection';
  static const String editCollection = '/collection/edit';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String error = '/error';
  static const String download = '/download';
  static const String nestedEdit = 'edit';
}
