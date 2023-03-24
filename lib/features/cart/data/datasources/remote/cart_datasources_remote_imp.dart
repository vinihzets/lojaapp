import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/model/cart_model.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/cart/data/datasources/cart_datasources.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';

class CartDataSourcesRemoteImp implements CartDataSource {
  DatabaseService databaseService;
  AuthService authService;
  CartModel cartModel;
  CartDataSourcesRemoteImp(
    this.databaseService,
    this.authService,
    this.cartModel,
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
}
