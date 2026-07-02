import 'package:flutter/material.dart';

/// A plain 또바기 character image with a graceful fallback (guardrail G4): if the
/// asset is missing it collapses to empty space instead of crashing. Used for
/// the lightweight screen greetings (onboarding / home / loading / relief) that
/// don't need the result screen's cheek ring.
class TobagiImage extends StatelessWidget {
  const TobagiImage(this.asset, {super.key, this.size = 56});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => SizedBox(width: size, height: size),
    );
  }
}
