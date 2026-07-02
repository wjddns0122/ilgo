import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/services/profile_service.dart';

/// Live text-size preview + 4-step slider. Shared by the settings screen
/// ([TextSizeView]) and the onboarding step ([OnboardingTextSizeView]).
///
/// The picker owns the slider index and reports the chosen scale through
/// [onChanged]; the parent owns "confirm" (persist + navigate). The preview
/// renders at the *candidate* scale via a local MediaQuery override, so it
/// updates live without touching the applied app-wide setting.
class TextSizePicker extends StatefulWidget {
  const TextSizePicker({
    super.key,
    required this.initialScale,
    required this.onChanged,
  });

  final double initialScale;
  final ValueChanged<double> onChanged;

  @override
  State<TextSizePicker> createState() => _TextSizePickerState();
}

class _TextSizePickerState extends State<TextSizePicker> {
  late final List<MapEntry<String, double>> _presets =
      ProfileService.textScalePresets.entries.toList();
  late int _index = _initialIndex();

  int _initialIndex() {
    final i = _presets.indexWhere((e) => e.value == widget.initialScale);
    return i < 0 ? 1 : i; // default 보통
  }

  double get _scale => _presets[_index].value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _preview(context),
        SizedBox(height: context.rs(28)),
        _slider(context),
      ],
    );
  }

  Widget _preview(BuildContext context) {
    return MediaQuery(
      data:
          MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(_scale)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(28), vertical: context.rs(28)),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.hairline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '미리보기',
              style: GoogleFonts.notoSansKr(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.stone),
            ),
            SizedBox(height: context.rs(10)),
            Text(
              '8월 15일까지\n6만 8천 원을 내야 해요.',
              style: GoogleFonts.notoSansKr(
                fontSize: 24,
                height: 1.4,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: context.rs(10)),
            Text(
              '건강보험료 고지서예요.',
              style:
                  GoogleFonts.notoSansKr(fontSize: 16, color: AppColors.stone),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slider(BuildContext context) {
    return Column(
      children: [
        // 가 (small) … 가 (big)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('가',
                style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(18), color: AppColors.stone)),
            Text('가',
                style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(32),
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink)),
          ],
        ),
        SizedBox(height: context.rs(8)),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: context.rs(8),
            activeTrackColor: AppColors.forest,
            inactiveTrackColor: AppColors.hairline,
            thumbColor: AppColors.card,
            overlayColor: AppColors.forest.withValues(alpha: 0.12),
            thumbShape:
                RoundSliderThumbShape(enabledThumbRadius: context.rs(14), elevation: 2),
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: _index.toDouble(),
            min: 0,
            max: (_presets.length - 1).toDouble(),
            divisions: _presets.length - 1,
            onChanged: (v) => setState(() {
              _index = v.round();
              widget.onChanged(_scale);
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < _presets.length; i++)
              Text(
                _presets[i].key,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(15),
                  fontWeight: i == _index ? FontWeight.w700 : FontWeight.w600,
                  color: i == _index ? AppColors.forest : AppColors.stone,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
