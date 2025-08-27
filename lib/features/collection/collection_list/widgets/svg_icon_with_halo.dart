import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconWithHalo extends StatelessWidget {
  const SvgIconWithHalo({
    super.key,
    required this.asset,
    this.size = 28,
    this.haloOpacity = 0.15,
    this.haloColor = Colors.black,
    this.padding = const EdgeInsets.all(6),
    this.iconColor,
  });

  final String asset;
  final double size; // diametro totale (cerchio incluso)
  final double haloOpacity; // 0..1
  final Color haloColor;
  final EdgeInsets padding; // “aria” tra cerchio e icona
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: haloColor.withValues(
          alpha: haloOpacity,
        ), // cerchiolino scuro semi-trasparente
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: padding,
        child: SvgPicture.asset(
          asset,
          fit: BoxFit.contain,
          colorFilter:
              iconColor != null
                  ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                  : null,
        ),
      ),
    );
  }
}
