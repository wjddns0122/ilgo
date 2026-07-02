import 'analysis.dart';
import 'risk.dart';

/// 또바기 (the reading companion) presentation state. Drives which character
/// art shows and the caption tone. Pure data — no Flutter deps — so it is
/// unit-testable without a widget or asset.
enum TobagiState { idle, thinking, reading, caution, warn, safe, cheer, victim }

const _assets = <TobagiState, String>{
  TobagiState.idle: 'assets/character/CuteTobak.png',
  TobagiState.thinking: 'assets/character/WonderingTobak.png',
  TobagiState.reading: 'assets/character/ReadingBookTobak.png',
  TobagiState.caution: 'assets/character/WonderingTobak.png',
  TobagiState.warn: 'assets/character/SurprisingTobak.png',
  TobagiState.safe: 'assets/character/BeautifulTobak.png',
  TobagiState.cheer: 'assets/character/JumpingTobak.png',
  TobagiState.victim: 'assets/character/TearTobak.png',
};

/// Asset path for a state (always non-null — every state maps to a PNG).
String tobagiAsset(TobagiState s) => _assets[s]!;

/// Highest-severity risk (red > yellow/unknown > green), or null.
Risk? topRisk(Analysis a) {
  if (a.risks.isEmpty) return null;
  int sev(String l) => l == 'red' ? 3 : (l == 'green' ? 1 : 2);
  return a.risks.reduce((x, y) => sev(y.level) > sev(x.level) ? y : x);
}

/// Result-screen state from the analysis's top risk. No risk → safe.
/// Unknown level → caution (never hide a possible risk).
TobagiState tobagiStateForResult(Analysis a) {
  final top = topRisk(a);
  if (top == null) return TobagiState.safe;
  switch (top.level) {
    case 'red':
      return TobagiState.warn;
    case 'green':
      return TobagiState.safe;
    default:
      return TobagiState.caution; // yellow / unknown
  }
}

/// 또바기's line + what to read aloud on the result screen.
///
/// Tone is situational: warning/caution use 존댓말 for weight; safe/neutral use
/// 다정한 반말. English output (`lang == 'en'`) uses a single warm tone (Korean's
/// 반말/존댓말 split doesn't apply).
class TobagiLine {
  const TobagiLine({
    required this.state,
    required this.caption,
    required this.speakText,
  });

  final TobagiState state;

  /// Short speech shown as a caption next to the character.
  final String caption;

  /// What TTS reads when the user taps (the summary, or the caption as fallback).
  final String speakText;
}

TobagiLine tobagiResultLine(Analysis a) {
  final state = tobagiStateForResult(a);
  final en = a.lang == 'en';
  final summary = a.summaryOneLine?.trim() ?? '';

  String caption;
  switch (state) {
    case TobagiState.warn:
      caption = en
          ? 'This could be risky. If there is a link, please do not tap it.'
          : '이거 위험할 수 있어요. 링크가 있으면 누르지 마세요.'; // 존댓말
    case TobagiState.caution:
      caption = en
          ? "Let's double-check this one to be safe."
          : '이건 한번 확인해보는 게 좋아요.'; // 존댓말
    case TobagiState.safe:
      caption = en
          ? 'This looks okay. No need to worry.'
          : '이건 안전해 보여. 걱정 마.'; // 반말
    default:
      caption = en ? "Here's what this says." : '이 글은 이런 뜻이야.'; // 반말
  }

  return TobagiLine(
    state: state,
    caption: caption,
    speakText: summary.isNotEmpty ? summary : caption,
  );
}
