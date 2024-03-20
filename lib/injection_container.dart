import 'package:get_it/get_it.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/auth_user_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/login_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! provider
  sl.registerFactory<AuthProvider>(
    () => AuthProvider(
      loginUsecase: sl(),
      signUpUsecase: sl(),
      authUserUsecase: sl(),
      logoutUsecase: sl(),
    ),
  );

  //! repository

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
    ),
  );

  //! usecase

  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton<AuthUserUsecase>(
    () => AuthUserUsecase(
      authRepository: sl(),
    ),
  );

  //! dataSource

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  //! external
}
