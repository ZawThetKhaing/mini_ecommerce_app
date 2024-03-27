import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_ecommerce_app_assignment/core/services/local_notification_service.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/auth_user_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/login_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/providers/home_nav_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/datasource/remote_datasource/order_remote_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/repository/order_repository_impl.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/repository/order_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/delete_order_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/get_order_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/set_order_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/update_order_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/datasource/product_local_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/datasource/product_remote_datasource.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/repository/product_repository_impl.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/repository/product_repository.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/add_to_cart_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/add_to_wish_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/delete_cart_item_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/delete_wish_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/get_cart_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/get_wish_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/usecaese/products_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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
    () => ProductsProvider(
      getProductsUsecase: sl(),
      addToCartUsecase: sl(),
      getCartListUsecase: sl(),
      deleteCartItemUsecase: sl(),
      addToWishListUsecase: sl(),
      getWishListUsecase: sl(),
      deleteWishListUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => PaymentProvider(
      setOrderUsecase: sl(),
      getOrderListUsecase: sl(),
      updateOrderUsecase: sl(),
      deleteOrderUsecase: sl(),
      localNotification: sl(),
    ),
  );

  //! repository

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductsRepositoryImpl(
      productRemoteDataSource: sl(),
      productLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      orderRemoteDataSource: sl(),
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
      productRepository: sl(),
    ),
  );
  sl.registerLazySingleton<AddToCartUsecase>(
    () => AddToCartUsecase(
      productRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GetCartListUsecase>(
    () => GetCartListUsecase(
      productRepository: sl(),
    ),
  );

  sl.registerLazySingleton<DeleteCartItemUsecase>(
    () => DeleteCartItemUsecase(
      productRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AddToWishListUsecase>(
    () => AddToWishListUsecase(
      productRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GetWishListUsecase>(
    () => GetWishListUsecase(
      productRepository: sl(),
    ),
  );

  sl.registerLazySingleton<DeleteWishListUsecase>(
    () => DeleteWishListUsecase(
      productRepository: sl(),
    ),
  );

  sl.registerLazySingleton<SetOrderUsecase>(
    () => SetOrderUsecase(
      orderRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GetOrderListUsecase>(
    () => GetOrderListUsecase(
      orderRepository: sl(),
    ),
  );

  sl.registerLazySingleton<UpdateOrderUsecase>(
    () => UpdateOrderUsecase(
      orderRepository: sl(),
    ),
  );

  sl.registerLazySingleton<DeleteOrderUsecase>(
    () => DeleteOrderUsecase(
      orderRepository: sl(),
    ),
  );

  //! dataSource

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl());

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(
      firebaseFirestore: sl(),
      uuid: sl(),
    ),
  );

  //! external

  await sl<ProductLocalDataSource>().initDb();

  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  sl.registerLazySingleton<Uuid>(
    () => const Uuid(),
  );

  sl.registerLazySingleton<LocalNotification>(
    () => LocalNotification(),
  );

  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}
