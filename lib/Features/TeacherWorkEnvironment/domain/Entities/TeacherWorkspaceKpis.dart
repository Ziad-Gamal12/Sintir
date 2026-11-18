// ignore_for_file: file_names

class TeacherWorkspaceKpis {
  const TeacherWorkspaceKpis({
    this.newStudents = 0,
    this.previousNewStudents = 0,
    this.netEarnings = 0,
    this.ratingsSum = 0,
    this.ratingsCount = 0,
    this.totalStudents = 0,
    this.publishedCourses = 0,
  });

  final int newStudents;
  final int previousNewStudents;
  final double netEarnings;
  final int ratingsSum;
  final int ratingsCount;
  final int totalStudents;
  final int publishedCourses;

  int get studentsChange => newStudents - previousNewStudents;

  bool get hasRatings => ratingsCount > 0;

  double get averageRating => hasRatings ? ratingsSum / ratingsCount : 0;
}
