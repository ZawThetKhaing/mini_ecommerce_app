import 'package:mini_ecommerce_app_assignment/core/command/login_command.dart';
import 'package:mini_ecommerce_app_assignment/core/command/sign_up_command.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  ResultFuture<UserEntity> signUp(SignUpCommand signUpCommand);
  ResultFuture<UserEntity> login(LoginCommand loginCommand);
  ResultFuture<UserEntity> signUpOrLoginWithGoogle();

  ResultVoid logout();
  Stream<UserEntity> get authUser;
}
