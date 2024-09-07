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
      required this.socialLinks});
  toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "uid": uid,
      "address": address,
      "phoneNumber": phoneNumber,
      "subject": subject,
      "workExperience": workExperience,
      "gender": gender,
      "profilePicurl": profilePicurl,
      "stete": stete,
      "socialLinks": socialLinks
    };
  }
}
