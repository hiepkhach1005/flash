class User{
  final String email;
  final String password;
  final String fullName;
  final int roleID;
  final int phone;
  final String address;
  final String DOB;
  final String gender;

  User({
    required this.email,
    required this.password,
    required this.fullName,
    required this.roleID,
    required this.phone,
    required this.address,
    required this.DOB,
    required this.gender
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      email:json['email'],
      password: json['password'],
      fullName:json['fullName'],
      roleID: json['roleID'],
      phone:json['phone'],
      address: json['address'],
      DOB:json['DOB'],
      gender: json['gender'],

    );
  }


}