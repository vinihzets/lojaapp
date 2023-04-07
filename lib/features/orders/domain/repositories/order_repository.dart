import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, String>> initPlatformState();

  Future<Either<Failure, PaymentEntity>> createPreference();
}
