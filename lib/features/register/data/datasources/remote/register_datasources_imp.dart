import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/register/data/datasources/register_datasources.dart';
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

      db.add({
        'email': email,
      }).then((value) => {
            db.doc(value.id).update({
              'docId': value.id,
              'userId': authService.auth.currentUser!.uid,
            })
          });

      return Right(registerRequest);
    } on FirebaseAuthException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao identificado'));
    }
  }
}
