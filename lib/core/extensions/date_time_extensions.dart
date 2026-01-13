extension DateTimeExtensions on DateTime {
  String messageFormat() {
    final now = DateTime.now();

    // Normalize dates to remove time part
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(year, month, day);

    final differenceInDays = today.difference(date).inDays;

    if (differenceInDays == 0) {
      // Today → 01:30 am
      final hour12 = hour % 12 == 0 ? 12 : hour % 12;
      final period = hour >= 12 ? 'pm' : 'am';

      return '${_twoDigits(hour12)}:${_twoDigits(minute)} $period';
    }

    if (differenceInDays == 1) {
      // Yesterday
      return 'Yesterday';
    }

    // 2 days ago, 3 days ago, ...
    return '$differenceInDays days ago';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
