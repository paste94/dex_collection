import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo extends ConsumerStatefulWidget {
  const AppInfo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppInfoState();
}

class _AppInfoState extends ConsumerState<AppInfo> {
  String _version = "";

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = "${info.version}+${info.buildNumber}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16),

              Image.asset('assets/app/icon.png', height: 100),

              SizedBox(height: 16),
              Text('v$_version', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
