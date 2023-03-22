import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';

import 'package:lojaapp/features/cart/data/datasources/cart_datasources.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/entities/cart_products_entity.dart';

class CartDataSourcesRemoteImp implements CartDataSource {
  DatabaseService databaseService;
  AuthService authService;

  CartDataSourcesRemoteImp(
    this.databaseService,
    this.authService,
  );

  @override
  Future<Either<Failure, List<CartProductsDto>>> getCartItems() async {
    try {
      final dbCart = databaseService.db
          .collection('cart')
          .doc(authService.auth.currentUser!.uid)
          .collection('items');

      final dbRequest = await dbCart.get();
      final list = dbRequest.docs
          .map((e) => CartProductsDto.fromJson(e.data()))
          .toList();

      return Right(list);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? 'Erro nulo'));
    }
  }
}
