import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/orders/data/datasources/order_datasources.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';
import 'package:lojaapp/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImp implements OrderRepository {
  OrderDataSources orderDataSources;

  OrderRepositoryImp(this.orderDataSources);

  Future<Either<Failure, List<OrderEntity>>> getOrders() {
    return orderDataSources.getOrders();
  }

  @override
  Future<Either<Failure, String>> initPlatformState() {
    return orderDataSources.initPlatformState();
  }

  @override
  Future<Either<Failure, PaymentEntity>> createPreference(OrderEntity entity) {
    return orderDataSources.createPreference(entity);
  }

  @override
  Future<Either<Failure, void>> statusIncrement(OrderEntity entity) {
    return orderDataSources.statusIncrement(entity);
  }
}
