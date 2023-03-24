import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';

abstract class GetOrdersUseCase {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
}
