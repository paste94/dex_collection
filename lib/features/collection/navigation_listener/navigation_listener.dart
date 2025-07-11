import 'package:dex_collection/features/collection/details/provider/index_provider.dart';
import 'package:dex_collection/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationListener extends ConsumerStatefulWidget {
  final Widget child;
  const NavigationListener({required this.child, super.key});

  @override
  ConsumerState<NavigationListener> createState() => _NavigationListenerState();
}

class _NavigationListenerState extends ConsumerState<NavigationListener> {
  @override
  void initState() {
    super.initState();

    ref.listen<int?>(indexProvider, (previous, next) {
      if (next != null) {
        context.go(ROUTES.collectionDetails); // vai a pagina B
      } else {
        context.go(ROUTES.home); // torna a pagina A
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
