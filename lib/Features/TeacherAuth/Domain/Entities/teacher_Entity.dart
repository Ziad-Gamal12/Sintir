// ignore_for_file: file_names, camel_case_types

class teacherEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String uid;
  final String address;
  final String phoneNumber;
  final String subject;
  final String workExperience;
  final String gender;
  final String profilePicurl;
  final String stete;
  final List socialLinks;
  final String kind; //teacher or Studednt
  final String joinedDate;
  teacherEntity(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.uid,
      required this.address,
      required this.phoneNumber,
      required this.subject,
      required this.workExperience,
      required this.gender,
      required this.profilePicurl,
      required this.stete,
      required this.socialLinks,
      required this.kind,
      required this.joinedDate});
}
