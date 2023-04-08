import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_entity.dart';

abstract class OrderDataSources {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, String>> initPlatformState();

  Future<Either<Failure, PaymentEntity>> createPreference(OrderEntity entity);
  Future<Either<Failure, void>> statusIncrement(OrderEntity orderEntity);
}
