class teacherEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String uid;
  /* final String adress;
  final String phoneNumber;
  final String gender;
  final String subject;
  final String workExperience;
  final String profilePic;
  final String kind; //(student or teacher)
  final String state; //(active or , inactive, Waiting)
  final List socialMediaLinks;
  */

  teacherEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uid,
  });
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "uid": uid,
    };
  }
}
