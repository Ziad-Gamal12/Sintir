// ignore_for_file: file_names

class Studententity {
  final String firstName, lastName;
  final String email;
  String? uid;
  final String birthDate;
  final String gender;
  final String schoolName;
  final String educationLevel;
  final String imageUrl;
  final String phoneNumber;
  final String kind;

  Studententity({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.schoolName,
    required this.educationLevel,
    required this.kind,
    required this.imageUrl,
    required this.phoneNumber,
  });
}
