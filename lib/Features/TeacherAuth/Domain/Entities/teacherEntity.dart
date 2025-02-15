// ignore_for_file: file_names, camel_case_types

class teacherEntity {
  String? uid;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String phoneNumber;
  final String subject;
  final String workExperience;
  final String gender;
  String? profilePicurl;
  final String state;
  final List socialLinks;
  final String kind; //teacher or Studednt
  final String joinedDate;
  teacherEntity(
      {this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.address,
      required this.phoneNumber,
      required this.subject,
      required this.workExperience,
      required this.gender,
      this.profilePicurl,
      required this.state,
      required this.socialLinks,
      required this.kind,
      required this.joinedDate});
}
