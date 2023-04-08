import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/order_entity.dart';
import '../entities/payment_entity.dart';

abstract class MercadoPagoUseCase {
  Future<Either<Failure, String>> initPlatformState();
  Future<Either<Failure, PaymentEntity>> createaPreference(OrderEntity entity);
}
