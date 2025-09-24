import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RetryCachedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final BoxFit? fit;
  final double? height;
  final double? width;

  const RetryCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.fit,
    this.height,
    this.width,
  });

  @override
  State<RetryCachedNetworkImage> createState() =>
      _RetryCachedNetworkImageState();
}

class _RetryCachedNetworkImageState extends State<RetryCachedNetworkImage> {
  bool _retried = false;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      placeholder: widget.placeholder,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      errorWidget: (context, url, error) {
        if (!_retried) {
          // evict dalla cache
          CachedNetworkImage.evictFromCache(widget.imageUrl).then((_) {
            // forzo un rebuild
            if (mounted) {
              setState(() {
                _retried = true;
              });
            }
          });

          // mentre riprova mostro il placeholder
          return widget.placeholder?.call(context, url) ??
              const Center(child: CircularProgressIndicator());
        }

        // seconda volta → errore vero
        return widget.errorWidget?.call(context, url, error) ??
            const Icon(Icons.error);
      },
    );
  }
}
