// ignore_for_file: file_names

class CourseCheckoutRequestException implements Exception {
  const CourseCheckoutRequestException(
      this.code, this.message, this.statusCode,
      {this.requestId});

  final String code;
  final String message;
  final int statusCode;
  final String? requestId;

  /// Non-sensitive identifier for matching this error to Supabase function logs.
  String get diagnosticDescription =>
      'code=$code status=$statusCode${requestId == null ? '' : ' requestId=$requestId'}';

  @override
  String toString() => message;
}
