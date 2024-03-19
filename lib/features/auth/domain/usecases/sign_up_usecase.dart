import 'package:mini_ecommerce_app_assignment/core/command/sign_up_command.dart';
import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';

class SignUpUsecase implements UseCaseWithParams<UserEntity, SignUpCommand> {
  const SignUpUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  ResultFuture<UserEntity> call(SignUpCommand params) =>
      authRepository.signUp(params);
}
