import 'package:mini_ecommerce_app_assignment/core/error/exception.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';

class AuthUserUsecase {
  const AuthUserUsecase({required this.authRepository});

  final AuthRepository authRepository;

  Stream<UserEntity> call() {
    try {
      return authRepository.authUser;
    } catch (e) {
      throw ServerException();
    }
  }
}
