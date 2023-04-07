import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';

abstract class MercadoPagoUseCase {
  Future<Either<Failure, String>> initPlatformState();
  Future<Either<Failure, PaymentEntity>> createaPreference();
}
