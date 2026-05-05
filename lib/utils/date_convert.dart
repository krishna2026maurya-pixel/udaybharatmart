import 'package:intl/intl.dart';

String formatChatDate(DateTime dateTime) {
  final istDate = toIndianTime(dateTime);

  final now = toIndianTime(DateTime.now());
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final messageDate = DateTime(istDate.year, istDate.month, istDate.day);

  if (messageDate == today) {
    return "Today";
  } else if (messageDate == yesterday) {
    return "Yesterday";
  } else {
    return DateFormat("d MMM yyyy").format(istDate); // e.g. 14 Aug 2025
  }
}

String formatMessageTime(DateTime dateTime) {
  return DateFormat("hh:mm a").format(dateTime); // e.g. 10:12 AM
}


DateTime toIndianTime(DateTime dateTime) {
  // Convert to local IST timezone (Asia/Kolkata)
  return dateTime.toUtc().add(const Duration(hours: 5, minutes: 30));
}