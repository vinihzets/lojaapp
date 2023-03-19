import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/categories/data/datasources/categories_datasource.dart';
import 'package:lojaapp/features/categories/data/dto/categories_dto.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';

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
