class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String address;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.address,
  });
}
