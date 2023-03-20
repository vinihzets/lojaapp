import 'package:firebase_core/firebase_core.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/products/data/datasources/products_datasource.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

class ProductsDataSourceRemoteImp implements ProductsDataSource {
  DatabaseService databaseService;

  ProductsDataSourceRemoteImp(this.databaseService);

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts(String uid) async {
    try {
      final getProducts = await databaseService.db
          .collection('products')
          .doc(uid)
          .collection('items')
          .get();
      final request =
          getProducts.docs.map((e) => ProductsDto.fromJson(e.data())).toList();
      return Right(request);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao encontrado'));
    }
  }
}
