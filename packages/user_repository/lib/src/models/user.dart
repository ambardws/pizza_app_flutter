import 'package:user_repository/src/entities/entities.dart';

class MyUser {
  String userId;
  String email;
  String name;
  bool hasActivaCart;

  MyUser(
      {required this.userId,
      required this.email,
      required this.name,
      required this.hasActivaCart});

  static final MyUser empty =
      MyUser(userId: '', email: '', name: '', hasActivaCart: false);

  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: userId, email: email, name: name, hasActivaCart: hasActivaCart);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        email: entity.email,
        name: entity.name,
        hasActivaCart: entity.hasActivaCart);
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActivaCart';
  }
}
