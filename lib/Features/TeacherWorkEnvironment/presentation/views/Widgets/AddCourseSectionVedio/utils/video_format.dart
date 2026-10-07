String formatMegabytes(int bytes) =>
    (bytes / (1024 * 1024)).toStringAsFixed(1);

String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.toString().padLeft(2, '0');
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
