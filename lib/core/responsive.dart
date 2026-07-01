import 'package:flutter/widgets.dart';

/// Width-based responsive scaling for the onboarding flow.
///
/// - Baseline design width = 390px.
/// - Anything wider than a phone is treated as a fixed [kOnbMaxWidth]-wide
///   content column (centered), so tablets/web don't stretch the layout.
/// - Narrow phones scale down proportionally, clamped to [0.82, 1.0] so text
///   never balloons past the design nor shrinks to unreadable.
const double kOnbMaxWidth = 480;

extension ResponsiveContext on BuildContext {
  double get _contentWidth {
    final w = MediaQuery.sizeOf(this).width;
    return w < kOnbMaxWidth ? w : kOnbMaxWidth;
  }

  /// Multiplier vs the 390px design baseline, clamped to [0.82, 1.0].
  double get scale => (_contentWidth / 390).clamp(0.82, 1.0);

  /// Scale a design px value responsively.
  double rs(double value) => value * scale;
}
