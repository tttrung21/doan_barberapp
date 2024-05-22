class UserModel {
  String? email;
  String? password;
  String? name;
  String? profilePic;
  String? uid;
  String? phoneNumber;
  String? role;
  String? dob;

  UserModel(
      {this.email,
      this.password,
      this.name,
      this.profilePic,
      this.uid,
      this.phoneNumber,
      this.role = 'user',
      this.dob});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        name: map['name'] ?? '',
        profilePic: map['profilePic'] ?? '',
        uid: map['uid'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        role: map['role'],
        dob: map['dob']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email ?? '',
      'password': password ?? '',
      'name': name ?? '',
      'profilePic': profilePic ?? '',
      'uid': uid ?? '',
      'phoneNumber': phoneNumber ?? '',
      'role': role ?? 'user',
      'dob' : dob ?? ''
    };
  }
}
