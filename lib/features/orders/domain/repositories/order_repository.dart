import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/order_entity.dart';
import '../entities/payment_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, String>> initPlatformState();

  Future<Either<Failure, PaymentEntity>> createPreference(OrderEntity entity);
  Future<Either<Failure, void>> statusIncrement(OrderEntity entity);
}
