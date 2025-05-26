class UserEntity {
  final String name;
  final String email;
  final String uId;
  final bool isAdmin;

  UserEntity({
    required this.name,
    required this.email,
    required this.uId,
    this.isAdmin = false,
  });
}
