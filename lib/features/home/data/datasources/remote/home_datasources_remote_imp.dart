import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/features/home/data/datasources/home_datasources.dart';

class HomeDataSourceRemoteImp implements HomeDataSource {
  AuthService authService;

  HomeDataSourceRemoteImp(this.authService);

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final requestSignOut = await authService.auth.signOut();

      return Right(requestSignOut);
    } on FirebaseAuthException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }
}
