class OpeningHours {
  OpeningHours._(this._byWeekday);

  //        day        open close
  final Map<int, List<(int, int)>> _byWeekday;

  static const _days = {
    'Mo': 1,
    'Tu': 2,
    'We': 3,
    'Th': 4,
    'Fr': 5,
    'Sa': 6,
    'Su': 7,
  };

  static final _rulePattern = RegExp(
    r'^(.*?)\s*((?:\d{1,2}:\d{2}-\d{1,2}:\d{2})' //group 1
    r'(?:\s*,\s*\d{1,2}:\d{2}-\d{1,2}:\d{2})*|off)$', //group 2
  );

  static OpeningHours? tryParse(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final text = raw.trim();

    if (text == '24/7') {
      //Open all day and every day of the week
      return OpeningHours._({
        for (var d = 1; d <= 7; d++) d: [(0, 1440)], // 1440 minute
      });
    }

    try {
      final byWeekday = <int, List<(int, int)>>{};

      for (final rawRule in text.split(';')) {
        final rule = rawRule.trim();
        if (rule.isEmpty) continue;

        final match = _rulePattern.firstMatch(rule);
        if (match == null) //Monday to Friday 8am-5pm
          throw const FormatException('unsupported rule');

        final days = _parseDays(match.group(1)!);
        final timesPart = match.group(2)!;

        final ranges = <(int, int)>[];
        if (timesPart != 'off') {
          for (final piece in timesPart.split(',')) {
            //sometimes equal 08:00-12:00,14:00-18:00
            final bounds = piece.trim().split('-');
            final open = _minutes(bounds[0]);
            var close = _minutes(bounds[1]);
            if (close <= open) close = 1440; // overnight -> until midnight
            ranges.add((open, close));
          }
        }

        // Later rules override earlier ones for the same day (OSM semantics).
        for (final d in days) {
          byWeekday[d] = ranges;
        }
      }

      if (byWeekday.isEmpty) return null;
      return OpeningHours._(byWeekday);
    } catch (_) {
      return null;
    }
  }

  static List<int> _parseDays(String source) {
    final text = source.trim();
    if (text.isEmpty) return [1, 2, 3, 4, 5, 6, 7]; // no selector = every day

    final result = <int>[];
    for (final token in text.split(',')) {
      final t = token.trim();
      if (t.contains('-')) {
        final ends = t.split('-');
        final start = _days[ends[0].trim()];
        final end = _days[ends[1].trim()];
        if (start == null || end == null) throw const FormatException('day');
        var d = start;
        while (true) {
          result.add(d);
          if (d == end) break;
          d = d % 7 + 1; // wraps Su -> Mo, so "Fr-Mo" works
        }
      } else {
        final d = _days[t];
        if (d == null) throw const FormatException('day');
        result.add(d);
      }
    }
    return result;
  }

  static int _minutes(String hhmm) {
    final parts = hhmm.split(':');
    final h = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    if (h > 24 || m > 59 || (h == 24 && m != 0)) {
      throw const FormatException('time');
    }
    return h * 60 + m;
  }

  List<(int, int)> rangesFor(int weekday) => _byWeekday[weekday] ?? const [];

  List<DateTime> slotsFor(DateTime date, {int stepMinutes = 15}) {
    final slots = <DateTime>[];
    for (final (open, close) in rangesFor(date.weekday)) {
      for (var m = open; m <= close; m += stepMinutes) {
        slots.add(DateTime(date.year, date.month, date.day, m ~/ 60, m % 60));
      }
    }
    return slots;
  }
}
