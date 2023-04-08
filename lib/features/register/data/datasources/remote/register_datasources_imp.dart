import '../../../../../core/failure/failure.dart';
import '../../../../../core/services/auth/auth_service.dart';
import '../../../../../core/services/database/database_service.dart';
import '../register_datasources.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterDataSourceImp implements RegisterDataSource {
  AuthService authService;
  DatabaseService databaseService;

  RegisterDataSourceImp({
    required this.authService,
    required this.databaseService,
  });

  @override
  Future<Either<Failure, UserCredential>> register(
    String email,
    String password,
  ) async {
    try {
      final registerRequest = await authService.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final db = databaseService.db.collection('users');

      db.doc(authService.auth.currentUser!.uid).set({
        'email': email,
      });

      return Right(registerRequest);
    } on FirebaseAuthException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao identificado'));
    }
  }
}
