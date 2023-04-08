import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/services/database/database_service.dart';
import '../categories_datasource.dart';
import '../../dto/categories_dto.dart';
import '../../../domain/entities/categories_entity.dart';

class CategoriesDataSourceRemoteImp implements CategoriesDataSource {
  DatabaseService databaseService;

  CategoriesDataSourceRemoteImp(this.databaseService);

  @override
  Future<Either<Failure, List<CategoriesEntity>>> call() async {
    try {
      final dbRequest = await databaseService.db.collection('products').get();
      final requestCategories =
          dbRequest.docs.map((e) => CategoriesDto.fromJson(e.data())).toList();

      return Right(requestCategories);
    } on FirebaseAuthException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao encontrado'));
    }
  }
}
