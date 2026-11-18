// ignore_for_file: file_names

abstract final class TeacherEarningsPolicy {
  static const double teacherShare = 0.95;

  static double netFromGross(num gross) =>
      (gross * 100 * teacherShare).roundToDouble() / 100;
}
