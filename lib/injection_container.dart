import 'package:get_it/get_it.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/auth_user_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/login_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/providers/home_nav_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/datasource/product_remote_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/repository/get_product_repository_impl.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/repository/get_product_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/get_products_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/get_product_provider.dart';
import 'package:http/http.dart' as http;

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

  sl.registerFactory(() => HomeNavProvider());

  sl.registerFactory(
    () => GetProductsProvider(
      getProductsUsecase: sl(),
    ),
  );

  //! repository

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<GetProductRepository>(
    () => GetProductsRepositoryImpl(
      productRemoteDataSource: sl(),
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

  sl.registerLazySingleton<GetProductsUsecase>(
    () => GetProductsUsecase(
      getProductRepository: sl(),
    ),
  );

  //! dataSource

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

  //! external

  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}
