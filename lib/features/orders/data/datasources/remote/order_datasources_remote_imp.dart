import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/orders/data/datasources/order_datasources.dart';
import 'package:lojaapp/features/orders/data/dtos/order_dto.dart';
import 'package:lojaapp/features/orders/data/dtos/payment_dto.dart';
import 'package:lojaapp/features/orders/data/dtos/products_dto.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';
import 'package:lojaapp/features/orders/domain/entities/products_entity.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:http/http.dart' as http;

class OrderDataSourcesRemoteImp implements OrderDataSources {
  AuthService auth;
  DatabaseService databaseService;

  OrderDataSourcesRemoteImp(this.auth, this.databaseService);

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      final database = databaseService.db;
      final userId = auth.auth.currentUser!.uid;

      final documents = await database
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      final list =
          documents.docs.map((e) => OrderDto.fromJson(e.data())).toList();

      return Right(list);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, String>> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion = await MercadoPagoMobileCheckout.platformVersion ?? '';
      return Right(platformVersion);
    } on PlatformException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }

  Future<Either<Failure, PaymentEntity>> createPreference(
      OrderEntity entity) async {
    var url = Uri.parse(
        'https://api.mercadopago.com/checkout/preferences?access_token=TEST-3070843847140697-040512-6401310aa21c05c200efdffc93666002-185567692');

    Map<String, String> header = {
      'Authorization':
          'Bearer TEST-3070843847140697-040512-6401310aa21c05c200efdffc93666002-185567692',
      'Content-type': 'application/json'
    };

    toMap(ProductsEntity prod) {
      return {
        'title': prod.name,
        'description': prod.description,
        'picture_url': prod.image,
        'category_id': 'roupas',
        'quantity': prod.quantity,
        'currency_id': 'BRL',
        'unit_price': num.parse(prod.priceUnity),
      };
    }

    Map<String, dynamic> bodyPost = {
      "items": entity.products.map((e) => toMap(e)).toList(),
      "payer": {"email": auth.auth.currentUser!.email}
    };

    try {
      final convertJson = jsonEncode(bodyPost);

      var response = await http.post(url, headers: header, body: convertJson);
      Map<String, dynamic> decode = jsonDecode(response.body);

      inspect(response.statusCode);
      final decoded = PaymentDto.fromJson(decode);
      inspect(decoded);

      return Right(decoded);
    } on HttpResponse catch (e) {
      return Left(RemoteFailure(message: e.reasonPhrase));
    }
  }

  @override
  Future<Either<Failure, void>> statusIncrement(OrderEntity orderEntity) async {
    try {
      orderEntity.status++;
      inspect(orderEntity.status);
      final db = databaseService.db
          .collection('orders')
          .doc(orderEntity.orderId)
          .update({
        'status': orderEntity.status,
      });

      return Right(db);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }
}
