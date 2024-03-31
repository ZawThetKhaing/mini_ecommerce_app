import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/command/login_command.dart';
import 'package:mini_ecommerce_app_assignment/core/command/sign_up_command.dart';
import 'package:mini_ecommerce_app_assignment/core/error/faliure.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/model/user_model.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/auth_user_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/login_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/domain/usecases/sign_up_usecase.dart';

enum AuthStatus {
  initial,
  unauthenticated,
  authenticated,
  loading,
}

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.loginUsecase,
    required this.signUpUsecase,
    required this.authUserUsecase,
    required this.logoutUsecase,
    required this.googleLoginUsecase,
  }) {
    _authSubScription = authUserUsecase().listen(
      (event) {
        if (event.id.isNotEmpty) {
          _authStatus = AuthStatus.authenticated;
          _user = UserModel.fromEntity(event);
          notifyListeners();
        }
      },
    );
  }
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final AuthUserUsecase authUserUsecase;
  final LogoutUsecase logoutUsecase;
  final GoogleLoginUsecase googleLoginUsecase;

  late final StreamSubscription _authSubScription;

  UserModel? _user;

  UserModel? get user => _user;

  AuthStatus _authStatus = AuthStatus.initial;

  AuthStatus get authStatus => _authStatus;

  Future<bool> loginWithEmail(LoginCommand loginCommand) =>
      loginOrSignUp(loginCommand: loginCommand);

  Future<bool> signUpwithEmail(SignUpCommand signUpCommand) =>
      loginOrSignUp(signUpCommand: signUpCommand);

  Future<bool> googleLogin() async {
    final result = await googleLoginUsecase();

    return result.fold((l) => false, (r) => true);
  }

  Future<bool> loginOrSignUp(
      {LoginCommand? loginCommand, SignUpCommand? signUpCommand}) async {
    Either<Failure, UserEntity>? result;
    if (loginCommand != null) {
      result = await loginUsecase(loginCommand);
    }
    if (signUpCommand != null) {
      result = await signUpUsecase(signUpCommand);
    }
    if (result != null) {
      return result.fold(
        (l) {
          _authStatus = AuthStatus.unauthenticated;
          notifyListeners();

          return false;
        },
        (entity) {
          _authStatus = AuthStatus.authenticated;

          _user = UserModel.fromEntity(entity);
          notifyListeners();

          return true;
        },
      );
    } else {
      _authStatus = AuthStatus.unauthenticated;
      notifyListeners();

      return false;
    }
  }

  Future<void> logout() async {
    await logoutUsecase();
    _authStatus = AuthStatus.unauthenticated;
    _user = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubScription.cancel();
    super.dispose();
  }
}
