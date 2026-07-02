/// D-day helpers shared by the home/library deadline chips and the in-app
/// deadline alert.
abstract class Deadline {
  /// Whole days from today (date-only) until [raw] (`YYYY-MM-DD`).
  /// 0 = due today, negative = past, null = missing/unparseable.
  static int? daysLeft(String? raw, {DateTime? now}) {
    if (raw == null || raw.trim().isEmpty) return null;
    final d = DateTime.tryParse(raw.trim());
    if (d == null) return null;
    final ref = now ?? DateTime.now();
    final today = DateTime(ref.year, ref.month, ref.day);
    return DateTime(d.year, d.month, d.day).difference(today).inDays;
  }

  /// Chip label: "오늘까지", "D-3" … null when past or no deadline
  /// (past deadlines keep the plain date label instead of a countdown).
  static String? dDayLabel(String? raw, {DateTime? now}) {
    final days = daysLeft(raw, now: now);
    if (days == null || days < 0) return null;
    return days == 0 ? '오늘까지' : 'D-$days';
  }

  /// Within a week (and not past) → highlighted in the UI.
  static bool isUrgent(String? raw, {int within = 7, DateTime? now}) {
    final days = daysLeft(raw, now: now);
    return days != null && days >= 0 && days <= within;
  }
}
