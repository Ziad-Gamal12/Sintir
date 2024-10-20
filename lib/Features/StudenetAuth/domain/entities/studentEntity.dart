// ignore_for_file: file_names

class Studententity {
  final String firstName, lastName;
  final String email;
  final DateTime birthDate;
  final String gender;
  final String schoolName;
  final String educationLevel;
  String? studentID;
  String? imageUrl;
  final String phoneNumber;
  final String password;

  Studententity(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.birthDate,
      required this.gender,
      required this.schoolName,
      required this.educationLevel,
      this.studentID,
      this.imageUrl,
      required this.phoneNumber,
      required this.password});
}
