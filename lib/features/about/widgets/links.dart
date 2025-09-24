import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class Links extends ConsumerWidget {
  const Links({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card.outlined(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.links,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Text(AppLocalizations.of(context)!.disclaimer_open_source),
              SizedBox(height: 8),

              /// GITHUB BUTTON
              OutlinedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset('assets/icons/github.svg'),
                    ),
                    SizedBox(width: 8),

                    Expanded(
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.github_repo),
                      ),
                    ),
                  ],
                ),
              ),

              /// PAYPAL DONATIONS
              OutlinedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset('assets/icons/paypal.png'),
                    ),
                    SizedBox(width: 8),

                    Expanded(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.paypal_donation_button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
