// Unit tests for 또바기 companion state/line derivation (FE-3). Pure Dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:ilgo/data/models/analysis.dart';
import 'package:ilgo/data/models/tobagi.dart';

Analysis _mk(String level, {String lang = 'ko', String? summary}) =>
    Analysis.fromJson(<String, dynamic>{
      'status': 'done',
      'output_mode': lang == 'en' ? 'native' : 'easy_korean',
      'lang': lang,
      'summary_one_line': summary,
      'risks': level.isEmpty
          ? <dynamic>[]
          : [
              {'id': 'r', 'level': level, 'type': '사기', 'message': 'm'}
            ],
    });

void main() {
  group('tobagiStateForResult', () {
    test('red → warn, yellow → caution, green → safe, none → safe', () {
      expect(tobagiStateForResult(_mk('red')), TobagiState.warn);
      expect(tobagiStateForResult(_mk('yellow')), TobagiState.caution);
      expect(tobagiStateForResult(_mk('green')), TobagiState.safe);
      expect(tobagiStateForResult(_mk('')), TobagiState.safe);
    });

    test('unknown level → caution (never hide a possible risk)', () {
      expect(tobagiStateForResult(_mk('weird')), TobagiState.caution);
    });

    test('picks the most severe risk when several are present', () {
      final a = Analysis.fromJson(<String, dynamic>{
        'status': 'done',
        'output_mode': 'easy_korean',
        'lang': 'ko',
        'risks': [
          {'id': '1', 'level': 'green', 'type': '기한', 'message': 'a'},
          {'id': '2', 'level': 'red', 'type': '사기', 'message': 'b'},
        ],
      });
      expect(tobagiStateForResult(a), TobagiState.warn);
    });
  });

  group('tobagiAsset', () {
    test('every state maps to a character png', () {
      for (final s in TobagiState.values) {
        expect(tobagiAsset(s), startsWith('assets/character/'));
        expect(tobagiAsset(s), endsWith('.png'));
      }
    });
  });

  group('tobagiResultLine', () {
    test('Korean warning is 존댓말, safe is 반말', () {
      expect(tobagiResultLine(_mk('red')).caption, contains('마세요'));
      expect(tobagiResultLine(_mk('green')).caption, contains('걱정 마'));
    });

    test('English output uses a single tone (no Korean honorific ending)', () {
      final l = tobagiResultLine(_mk('red', lang: 'en'));
      expect(l.caption, contains('risky'));
      expect(l.caption.contains('세요'), isFalse);
    });

    test('speakText is the summary when present, else the caption', () {
      expect(tobagiResultLine(_mk('green', summary: '요약입니다')).speakText,
          '요약입니다');
      final noSummary = tobagiResultLine(_mk('green'));
      expect(noSummary.speakText, noSummary.caption);
    });
  });

  group('backend override + all-done', () {
    Analysis mk(Map<String, dynamic> extra) => Analysis.fromJson(<String, dynamic>{
          'status': 'done',
          'output_mode': 'easy_korean',
          'lang': 'ko',
          ...extra,
        });

    test('valid character_state overrides the risk-derived state', () {
      final a = mk({
        'character_state': 'victim',
        'risks': [
          {'id': 'r', 'level': 'green', 'type': '사기', 'message': 'm'}
        ],
      });
      expect(tobagiStateForResult(a), TobagiState.victim);
    });

    test('invalid character_state falls back to the risk-derived state', () {
      final a = mk({
        'character_state': 'nonsense',
        'risks': [
          {'id': 'r', 'level': 'red', 'type': '사기', 'message': 'm'}
        ],
      });
      expect(tobagiStateForResult(a), TobagiState.warn);
    });

    test('character_line overrides the client caption', () {
      final a = mk({'character_line': '내가 도와줄게', 'summary_one_line': 's'});
      expect(tobagiResultLine(a).caption, '내가 도와줄게');
    });

    test('all actions done → cheer (ignores AI line)', () {
      final a = mk({
        'character_line': '위험해요',
        'risks': [
          {'id': 'r', 'level': 'red', 'type': '사기', 'message': 'm'}
        ],
      });
      final line = tobagiResultLine(a, allActionsDone: true);
      expect(line.state, TobagiState.cheer);
      expect(line.caption, contains('잘했어'));
    });
  });
}
