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
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';
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

  Future<Either<Failure, PaymentEntity>> createPreference() async {
    var url = Uri.parse(
        'https://api.mercadopago.com/checkout/preferences?access_token=TEST-3070843847140697-040512-6401310aa21c05c200efdffc93666002-185567692');

    Map<String, String> header = {'Content-type': 'application/json'};

    Map bodyPost = {
      "items": [
        {
          "title": "Dummy Item",
          "description": "Multicolor Item",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": 10.0
        }
      ],
      "payer": {"email": "payer@email.com"}
    };

    try {
      final convertJson = jsonEncode(bodyPost);

      var response = await http.post(url, headers: header, body: convertJson);
      Map<String, dynamic> decode = jsonDecode(response.body);
      final decoded = PaymentDto.fromJson(decode);

      return Right(decoded);
    } on Response catch (_) {
      return Left(RemoteFailure(message: 'tente novamente mais tarde'));
    }
  }
}
