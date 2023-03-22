import 'package:firebase_core/firebase_core.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/products/data/datasources/products_datasource.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

class ProductsDataSourceRemoteImp implements ProductsDataSource {
  DatabaseService databaseService;
  AuthService authService;
  List<ProductsDto> products = [];

  ProductsDataSourceRemoteImp(this.databaseService, this.authService);

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

  @override
  Future<Either<Failure, dynamic>> addItemToCart(
      ProductsDto productsDto) async {
    try {
      final String idUser = authService.auth.currentUser!.uid;

      final dbCart =
          databaseService.db.collection('cart').doc(idUser).collection('items');

      final dbRequest =
          await dbCart.add(productsDto.toResumedMap()).then((value) {
        dbCart.doc(value.id).update({'id': value.id, 'quantity': 1});
      });

      products.add(productsDto);

      return Right(dbRequest);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao encontrado'));
    }
  }
}
