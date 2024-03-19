import 'package:dartz/dartz.dart';
import 'package:mini_ecommerce_app_assignment/core/error/faliure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;
