import 'package:dartz/dartz.dart';
import 'package:mini_ecommerce_app_assignment/core/command/login_command.dart';
import 'package:mini_ecommerce_app_assignment/core/command/sign_up_command.dart';
import 'package:mini_ecommerce_app_assignment/core/error/faliure.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.authRemoteDataSource});

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Stream<UserEntity> get authUser {
    return authRemoteDataSource.user.map((userModel) {
      return userModel == null
          ? const UserEntity(id: '', name: '', email: '', imageUrl: '')
          : userModel.toEntity();
    });
  }

  @override
  ResultFuture<UserEntity> login(LoginCommand loginCommand) async {
    final result = await authRemoteDataSource.login(loginCommand);

    return result.fold(
      (l) => Left(
        ServerFailure(
          l.message,
        ),
      ),
      (userModel) => Right(
        userModel.toEntity(),
      ),
    );
  }

  @override
  ResultFuture<UserEntity> signUp(SignUpCommand signUpCommand) async {
    final result = await authRemoteDataSource.signUp(signUpCommand);

    return result.fold(
      (l) => Left(
        ServerFailure(l.message),
      ),
      (userModel) => Right(
        userModel.toEntity(),
      ),
    );
  }

  @override
  ResultVoid logout() async {
    final result = await authRemoteDataSource.logout();

    return result.fold(
      (l) => Left(ServerFailure(l.message)),
      (r) => const Right(null),
    );
  }
}
