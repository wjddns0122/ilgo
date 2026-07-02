import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/tts_service.dart';

/// "소리로 듣기" screen (Figma node 30:1487): reads the explanation aloud with
/// on-device TTS, highlighting the current sentence and animating a waveform in
/// sync with playback progress.
class ListenTtsView extends StatefulWidget {
  const ListenTtsView({super.key});

  @override
  State<ListenTtsView> createState() => _ListenTtsViewState();
}

// Design palette specific to this screen.
const _mutedText = Color(0xFFA59D8F);
const _highlightBg = Color(0xFFF0E4C6);
const _waveIdle = Color(0xFFC9B594);

// Static waveform bar heights (from the Figma design).
const _barHeights = <double>[32, 58, 74, 45, 66, 29, 53, 40, 69, 34];

class _ListenTtsViewState extends State<ListenTtsView> {
  final TtsService _tts = Get.find<TtsService>();

  int _speedIndex = 0;
  static const _speeds = <double>[1.0, 1.25, 1.5, 0.75];

  late final String _title;
  late final String _lang;
  late final List<String> _sentences;
  late final String _fullText;

  double get _rate => (0.45 * _speeds[_speedIndex]).clamp(0.15, 1.0);

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    final text = (args is Map && args['text'] is String)
        ? args['text'] as String
        : '';
    final doc = (args is Map && args['title'] is String)
        ? args['title'] as String
        : '';
    _lang = (args is Map && args['lang'] is String) ? args['lang'] as String : 'ko';
    _title = doc.isEmpty ? '소리로 듣기' : '$doc · 소리로 듣기';
    _sentences = _splitSentences(text.isEmpty ? '읽어드릴 내용이 없어요.' : text);
    _fullText = _sentences.join(' ');
    WidgetsBinding.instance.addPostFrameCallback((_) => _play());
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  List<String> _splitSentences(String text) {
    final out = <String>[];
    final buffer = StringBuffer();
    for (final ch in text.characters) {
      buffer.write(ch);
      if (ch == '.' || ch == '!' || ch == '?') {
        out.add(buffer.toString().trim());
        buffer.clear();
      }
    }
    if (buffer.toString().trim().isNotEmpty) out.add(buffer.toString().trim());
    return out.isEmpty ? [text] : out;
  }

  Future<void> _play() => _tts.speak(_fullText, lang: _lang, rate: _rate);

  void _togglePlay() {
    if (_tts.isSpeaking.value) {
      _tts.stop();
    } else {
      _play();
    }
  }

  void _restart() {
    _tts.stop();
    _play();
  }

  void _cycleSpeed() {
    setState(() => _speedIndex = (_speedIndex + 1) % _speeds.length);
    if (_tts.isSpeaking.value) _play(); // restart at the new rate
  }

  /// Which sentence is currently spoken, from playback progress (0..1).
  int _sentenceAt(double p) {
    if (_sentences.length <= 1) return 0;
    final target = p * _fullText.length;
    var acc = 0;
    for (var i = 0; i < _sentences.length; i++) {
      acc += _sentences[i].length + 1;
      if (target <= acc) return i;
    }
    return _sentences.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Obx(() {
                        final p = _tts.progress.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: context.rs(24)),
                            _readingText(context, _sentenceAt(p)),
                            SizedBox(height: context.rs(32)),
                            _waveform(context, p),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
                _controls(context),
                SizedBox(height: context.rs(12)),
                Center(
                  child: Text(
                    '천천히 또박또박 읽어드려요',
                    style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(18), color: AppColors.stone),
                  ),
                ),
                SizedBox(height: context.rs(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          context.rs(15), context.rs(15), context.rs(28), context.rs(8)),
      child: Row(
        children: [
          SizedBox(
            width: context.rs(22),
            height: context.rs(22),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: context.rs(22),
              icon: const Icon(Icons.arrow_back, color: AppColors.ink),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: context.rs(12)),
          Icon(Icons.volume_up, size: context.rs(26), color: AppColors.stone),
          SizedBox(width: context.rs(10)),
          Expanded(
            child: Text(
              _title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(19),
                fontWeight: FontWeight.w700,
                color: AppColors.stone,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _readingText(BuildContext context, int highlight) {
    return RichText(
      text: TextSpan(
        children: [
          for (var i = 0; i < _sentences.length; i++)
            TextSpan(
              text: '${_sentences[i]} ',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(27),
                height: 1.7,
                fontWeight: FontWeight.w700,
                color: i == highlight ? AppColors.ink : _mutedText,
                backgroundColor:
                    i == highlight ? _highlightBg : Colors.transparent,
              ),
            ),
        ],
      ),
    );
  }

  Widget _waveform(BuildContext context, double p) {
    final playedTo = (p * _barHeights.length).round();
    return SizedBox(
      height: context.rs(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < _barHeights.length; i++) ...[
            if (i > 0) SizedBox(width: context.rs(5)),
            Container(
              width: context.rs(7),
              height: context.rs(_barHeights[i]),
              decoration: BoxDecoration(
                color: i < playedTo ? AppColors.forest : _waveIdle,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _controls(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: context.rs(34),
            icon: const Icon(Icons.replay, color: AppColors.forest),
            onPressed: _restart,
          ),
          SizedBox(width: context.rs(36)),
          _playButton(context),
          SizedBox(width: context.rs(36)),
          _speedPill(context),
        ],
      ),
    );
  }

  Widget _playButton(BuildContext context) {
    final s = context.rs(96);
    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        width: s,
        height: s,
        decoration:
            const BoxDecoration(color: AppColors.forest, shape: BoxShape.circle),
        child: Obx(() => Icon(
              _tts.isSpeaking.value ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: context.rs(40),
            )),
      ),
    );
  }

  Widget _speedPill(BuildContext context) {
    return GestureDetector(
      onTap: _cycleSpeed,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(16), vertical: context.rs(9)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.forest),
        ),
        child: Text(
          '${_speeds[_speedIndex]}x',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(19),
            fontWeight: FontWeight.w700,
            color: AppColors.forest,
          ),
        ),
      ),
    );
  }
}
