// ignore_for_file: file_names

class Studententity {
  final String firstName, lastName;
  final String email;
  String? birthDate;
  String? gender;
  String? schoolName;
  String? educationLevel;
  String? studentID;
  String? imageUrl;
  final String phoneNumber;
  String? kind;
  String? password;

  Studententity(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.birthDate,
      this.gender,
      this.schoolName,
      this.educationLevel,
      this.studentID,
      this.kind,
      this.imageUrl,
      required this.phoneNumber,
      this.password});
}
