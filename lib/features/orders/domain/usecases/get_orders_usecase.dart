import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/order_entity.dart';

abstract class GetOrdersUseCase {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
}
