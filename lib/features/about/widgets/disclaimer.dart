import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Disclaimer extends ConsumerWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card.outlined(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.disclaimer_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              // Text('''
              Text(AppLocalizations.of(context)!.disclaimer_intro),
              SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.disclaimer_sources),
              SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.disclaimer_rights),
              // '''),
            ],
          ),
        ),
      ),
    );
  }
}
