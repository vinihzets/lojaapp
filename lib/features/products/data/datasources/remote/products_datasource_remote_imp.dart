import 'package:firebase_core/firebase_core.dart';
import 'package:lojaapp/core/global/product_dto.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import '../../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/services/auth/auth_service.dart';
import '../../../../../core/services/database/database_service.dart';
import '../products_datasource.dart';

class ProductsDataSourceRemoteImp implements ProductsDataSource {
  DatabaseService databaseService;
  AuthService authService;
  ProductsDataSourceRemoteImp(this.databaseService, this.authService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(String uid) async {
    try {
      final getProducts = await databaseService.db
          .collection('products')
          .doc(uid)
          .collection('items')
          .get();

      final request =
          getProducts.docs.map((e) => ProductDto.fromJson(e.data())).toList();
      return Right(request);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao encontrado'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addItemToCart(ProductDto productsDto) async {
    try {
      final String idUser = authService.auth.currentUser!.uid;

      final dbCart =
          databaseService.db.collection('cart').doc(idUser).collection('items');

      final dbRequest =
          await dbCart.add(productsDto.toResumedMap()).then((value) {
        dbCart.doc(value.id).update({'id': value.id, 'quantity': 1});
      });

      return Right(dbRequest);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nao encontrado'));
    }
  }
}
