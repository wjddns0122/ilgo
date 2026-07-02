// Unit tests for the risk-type → help-contact recommendation (FE-1). Pure Dart,
// no Flutter binding — fast and network-free.

import 'package:flutter_test/flutter_test.dart';
import 'package:ilgo/core/help_recommend.dart';

void main() {
  group('recommendedHelp', () {
    test('사기 → 118 first, victim tier has 112/1332/132', () {
      final r = recommendedHelp('사기');
      expect(r.tier1.first.phone, '118');
      expect(r.victim, isNotNull);
      final phones = r.victim!.contacts.map((c) => c.phone).toList();
      expect(phones, containsAll(<String>['112', '1332', '132']));
    });

    test('스미싱/피싱 substrings also map to 118', () {
      expect(recommendedHelp('스미싱 의심').tier1.first.phone, '118');
      expect(recommendedHelp('보이스피싱').tier1.first.phone, '118');
    });

    test('임금/계약 → 1350 first, victim present', () {
      expect(recommendedHelp('임금').tier1.first.phone, '1350');
      expect(recommendedHelp('부당공제').tier1.first.phone, '1350');
      final r = recommendedHelp('계약');
      expect(r.tier1.first.phone, '1350');
      expect(r.victim, isNotNull);
    });

    test('건강보험 → 1577-1000, no victim tier', () {
      final r = recommendedHelp('건강보험');
      expect(r.tier1.first.phone, '1577-1000');
      expect(r.victim, isNull);
    });

    test('과태료/기타/null → no tier1, no victim (full screen only)', () {
      expect(recommendedHelp('과태료').tier1, isEmpty);
      expect(recommendedHelp('기타').victim, isNull);
      expect(recommendedHelp(null).tier1, isEmpty);
      expect(recommendedHelp('').victim, isNull);
    });

    test('112 is flagged as emergency', () {
      final police =
          recommendedHelp('사기').victim!.contacts.firstWhere((c) => c.phone == '112');
      expect(police.emergency, isTrue);
    });

    test('victim guidance is advisory (no "보상" promise)', () {
      final guide = recommendedHelp('사기').victim!.guide;
      expect(guide.contains('공식 절차'), isTrue);
      expect(guide.contains('보상'), isFalse);
    });
  });
}
