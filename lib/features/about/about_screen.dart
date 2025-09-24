import 'package:dex_collection/features/about/widgets/app_info.dart';
import 'package:dex_collection/features/about/widgets/disclaimer.dart';
import 'package:dex_collection/features/about/widgets/links.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.about)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [AppInfo(), Links(), Disclaimer()]),
        ),
      ),
    );
  }
}
