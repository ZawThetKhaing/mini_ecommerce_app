import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';

class GoogleLoginUsecase implements UseCaseWithoutParams<UserEntity> {
  final AuthRepository authRepository;

  GoogleLoginUsecase({required this.authRepository});

  @override
  ResultFuture<UserEntity> call() => authRepository.signUpOrLoginWithGoogle();
}
