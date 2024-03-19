import 'package:mini_ecommerce_app_assignment/core/usecase/usecase.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';

class LogoutUsecase implements UseCaseWithoutParams<void> {
  const LogoutUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  ResultVoid call() => authRepository.logout();
}
