import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/global/product_dto.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/services/auth/auth_service.dart';
import '../home_datasources.dart';

class HomeDataSourceRemoteImp implements HomeDataSource {
  AuthService authService;
  DatabaseService databaseService;

  HomeDataSourceRemoteImp(this.authService, this.databaseService);

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final requestSignOut = await authService.auth.signOut();

      return Right(requestSignOut);
    } on FirebaseAuthException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, List<ProductDto>>> getNews() async {
    try {
      final dbRequest = await databaseService.db
          .collection('news')
          .orderBy('createdAt', descending: true)
          .get();
      final objectList =
          dbRequest.docs.map((e) => ProductDto.fromJson(e.data())).toList();
      return Right(objectList);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }
}
