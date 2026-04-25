/// Formats a duration in seconds as MM:SS or H:MM:SS.
/// Returns '--' if [secs] is null.
String formatDuration(int? secs) {
  if (secs == null) return '--';
  final d = Duration(seconds: secs);
  final h = d.inHours.toString().padLeft(2, '0');
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return d.inHours > 0 ? '$h:$m:$s' : '$m:$s';
}
