/// Converts a target [DateTime] into a human-friendly relative time label.
/// 
/// Examples:
/// - If the target date is today → "Today"
/// - If tomorrow → "Tomorrow"
/// - If 5 days in future → "Next week"
/// - If 2 months in past → "2 months ago"
/// 
/// Used for badges that describe when a goal starts or ends.
String formatRelativeDate(DateTime targetDate) {
  final now = DateTime.now();
  final difference = targetDate.difference(now);

  // Future dates
  if (difference.inDays == 0) return 'Today';
  if (difference.inDays == 1) return 'Tomorrow';
  if (difference.inDays > 1 && difference.inDays <= 7) return 'Next week';
  if (difference.inDays <= 31) return 'Next month';
  if (difference.inDays > 31) return 'Next year';

  // Past dates
  if (difference.inDays == -1) return 'Yesterday';
  if (difference.inDays < -1 && difference.inDays >= -7) {
    return '${-difference.inDays} days ago';
  }
  if (difference.inDays < -7 && difference.inDays >= -31) {
    return '${(-difference.inDays / 7).round()} weeks ago';
  }
  if (difference.inDays < -31 && difference.inDays >= -365) {
    return '${(-difference.inDays / 30).round()} months ago';
  }

  return '${(-difference.inDays / 365).round()} years ago';
}

