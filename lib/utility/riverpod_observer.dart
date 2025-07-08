import 'package:dex_collection/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.d('''
{
  "provider": "${provider}",
  "newValue": "$newValue",
}''');
  }

  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    print('Provider ${provider} was initialized with $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    print('Provider ${provider} was disposed');
  }
}
