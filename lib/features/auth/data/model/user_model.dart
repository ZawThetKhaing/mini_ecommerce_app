import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        imageUrl: json['image_url'] ?? '',
      );

  factory UserModel.fromFirebase(User user) => UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        imageUrl: user.photoURL ?? '',
      );

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        imageUrl: entity.imageUrl,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image_url": imageUrl,
      };

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        imageUrl: imageUrl,
      );
}
