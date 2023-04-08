import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/services/auth/auth_service.dart';
import '../home_datasources.dart';

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
