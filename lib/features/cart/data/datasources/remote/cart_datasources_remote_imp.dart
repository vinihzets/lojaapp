import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/cart/data/datasources/cart_datasources.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

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

  @override
  Future<Either<Failure, void>> removeCartItems(String id) async {
    try {
      final dbRequest = await databaseService.db
          .collection('cart')
          .doc(authService.auth.currentUser!.uid)
          .collection('items')
          .doc(id)
          .delete();

      return Right(dbRequest);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, void>> decProduct(
      CartProductsDto cartProductsDto) async {
    try {
      cartProductsDto.quantity--;
      final dbRequest = await databaseService.db
          .collection('cart')
          .doc(authService.auth.currentUser!.uid)
          .collection('items')
          .doc(cartProductsDto.id)
          .update(cartProductsDto.toMap());

      return Right(dbRequest);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, void>> incProduct(
      CartProductsDto cartProductsDto) async {
    try {
      cartProductsDto.quantity++;
      final dbRequest = await databaseService.db
          .collection('cart')
          .doc(authService.auth.currentUser!.uid)
          .collection('items')
          .doc(cartProductsDto.id)
          .update(cartProductsDto.toMap());
      return Right(dbRequest);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, DocumentSnapshot>> discountCard(String coupon) async {
    try {
      final dbRequest =
          await databaseService.db.collection('coupons').doc(coupon).get();

      return Right(dbRequest);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, void>> addOrder(
    List<CartProductsDto> cartProductsDto,
    double productsPrice,
    double discount,
    double totalPrice,
  ) async {
    final dbService = databaseService.db;
    final userId = authService.auth.currentUser!.uid;

    try {
      final dbAddOrder = await dbService.collection('orders').add({
        'userId': userId,
        'products': cartProductsDto.map((e) => e.toMap()).toList(),
        'productsPrice': productsPrice,
        'discount': discount,
        'totalPrice': totalPrice,
        'status': 1,
      }).then((value) => dbService
          .collection('orders')
          .doc(value.id)
          .update({'orderId': value.id}));

      QuerySnapshot items = await databaseService.db
          .collection('cart')
          .doc(userId)
          .collection('items')
          .get();

      for (DocumentSnapshot document in items.docs) {
        document.reference.delete();
      }

      return Right(dbAddOrder);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }
}
