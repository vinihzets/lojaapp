import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';
import 'package:lojaapp/features/orders/domain/repositories/order_repository.dart';
import 'package:lojaapp/features/orders/domain/usecases/mercado_pago_usecase.dart';

class MercadoPagoUseCaseImp implements MercadoPagoUseCase {
  OrderRepository orderRepository;

  MercadoPagoUseCaseImp(this.orderRepository);

  @override
  Future<Either<Failure, String>> initPlatformState() {
    return orderRepository.initPlatformState();
  }

  Future<Either<Failure, PaymentEntity>> createaPreference() {
    return orderRepository.createPreference();
  }
}
