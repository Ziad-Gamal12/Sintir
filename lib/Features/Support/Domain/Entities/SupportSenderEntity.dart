class SupportSenderEntity {
  String name;
  String email;
  String phone;
  String uid;
  String photoUrl;
  String role;
  SupportSenderEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.uid,
    required this.photoUrl,
  });
  static SupportSenderEntity empty() {
    return SupportSenderEntity(
      name: '',
      email: '',
      phone: '',
      uid: '',
      photoUrl: 'https://cdn-icons-png.flaticon.com/128/149/149071.png',
      role: '',
    );
  }
}
