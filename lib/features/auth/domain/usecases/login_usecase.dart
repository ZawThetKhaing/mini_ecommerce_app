import 'package:mini_ecommerce_app_assignment/core/command/login_command.dart';
import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase implements UseCaseWithParams<UserEntity, LoginCommand> {
  const LoginUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  ResultFuture<UserEntity> call(LoginCommand params) =>
      authRepository.login(params);
}
