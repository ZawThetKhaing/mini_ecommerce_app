import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mini_ecommerce_app_assignment/core/command/login_command.dart';
import 'package:mini_ecommerce_app_assignment/core/command/sign_up_command.dart';
import 'package:mini_ecommerce_app_assignment/core/error/faliure.dart';
import 'package:mini_ecommerce_app_assignment/core/utils/typedef.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel?> get user;

  ResultFuture<UserModel> signUp(SignUpCommand signUpCommand);

  ResultFuture<UserModel> login(LoginCommand loginCommand);

  ResultFuture<UserModel> googleLogin();
  ResultVoid logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  @override
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        return null;
      } else {
        return UserModel.fromFirebase(user);
      }
    });
  }

  @override
  ResultFuture<UserModel> signUp(SignUpCommand signUpCommand) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUpCommand.email,
        password: signUpCommand.password,
      );

      if (userCredential.user == null) {
        return const Left(ServerFailure("Sign up failed!"));
      } else {
        await userCredential.user!.updateDisplayName(signUpCommand.name);
        return Right(UserModel.fromFirebase(userCredential.user!));
      }
    } catch (e) {
      return const Left(ServerFailure("Sign up failed!"));
    }
  }

  @override
  ResultFuture<UserModel> login(LoginCommand loginCommand) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: loginCommand.email,
        password: loginCommand.password,
      );

      if (userCredential.user == null) {
        return const Left(ServerFailure("Sign In Failed!"));
      } else {
        return Right(
          UserModel.fromFirebase(userCredential.user!),
        );
      }
    } catch (e) {
      return const Left(ServerFailure("Sign In Failed!"));
    }
  }

  @override
  ResultVoid logout() async {
    try {
      return Right(await _firebaseAuth.signOut());
    } catch (e) {
      return const Left(ServerFailure("Logout failed!"));
    }
  }

  @override
  ResultFuture<UserModel> googleLogin() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.user != null) {
        return Right(UserModel.fromFirebase(user.user!));
      } else {
        return const Left(ServerFailure("Google login failed!"));
      }
    } on Exception catch (e) {
      return const Left(ServerFailure("Google login failed!"));
    }
  }
}
