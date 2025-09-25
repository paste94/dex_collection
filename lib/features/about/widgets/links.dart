import 'package:dex_collection/config/config.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Links extends ConsumerWidget {
  const Links({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> _launchUrl(String urlStr) async {
      final Uri url = Uri.parse(urlStr);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

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
                onPressed: () => _launchUrl(GITHUB_ULR),
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
                onPressed: () => _launchUrl(PAYPAL_DONATION_URL),
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
