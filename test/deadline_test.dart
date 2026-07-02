// D-day helper tests — drives the home/library chips and the in-app alert.

import 'package:flutter_test/flutter_test.dart';
import 'package:ilgo/core/deadline.dart';

void main() {
  final now = DateTime(2026, 7, 2, 14, 30); // time of day must not matter

  group('Deadline.daysLeft', () {
    test('date-only difference', () {
      expect(Deadline.daysLeft('2026-07-02', now: now), 0);
      expect(Deadline.daysLeft('2026-07-05', now: now), 3);
      expect(Deadline.daysLeft('2026-07-01', now: now), -1);
    });

    test('null / blank / unparseable → null', () {
      expect(Deadline.daysLeft(null, now: now), isNull);
      expect(Deadline.daysLeft('  ', now: now), isNull);
      expect(Deadline.daysLeft('not-a-date', now: now), isNull);
    });
  });

  group('Deadline.dDayLabel', () {
    test('today / future / past', () {
      expect(Deadline.dDayLabel('2026-07-02', now: now), '오늘까지');
      expect(Deadline.dDayLabel('2026-07-05', now: now), 'D-3');
      expect(Deadline.dDayLabel('2026-06-30', now: now), isNull);
      expect(Deadline.dDayLabel(null, now: now), isNull);
    });
  });

  group('Deadline.isUrgent', () {
    test('within 7 days and not past', () {
      expect(Deadline.isUrgent('2026-07-02', now: now), isTrue);
      expect(Deadline.isUrgent('2026-07-09', now: now), isTrue);
      expect(Deadline.isUrgent('2026-07-10', now: now), isFalse);
      expect(Deadline.isUrgent('2026-07-01', now: now), isFalse);
      expect(Deadline.isUrgent(null, now: now), isFalse);
    });

    test('custom window', () {
      expect(Deadline.isUrgent('2026-07-05', within: 3, now: now), isTrue);
      expect(Deadline.isUrgent('2026-07-06', within: 3, now: now), isFalse);
    });
  });
}
