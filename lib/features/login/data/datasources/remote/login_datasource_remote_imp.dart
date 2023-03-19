import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/features/login/data/datasources/login_datasource.dart';

class LoginDataSourceRemoteImp implements LoginDataSource {
  AuthService authService;

  LoginDataSourceRemoteImp(this.authService);

  @override
  Future<Either<Failure, UserCredential>> login(
      String email, String password) async {
    try {
      final loginRequest = await authService.auth
          .signInWithEmailAndPassword(email: email, password: password);

      return Right(loginRequest);
    } on FirebaseAuthException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao encontrado'));
    }
  }
}
