import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/order_entity.dart';

abstract class OrderStatusUseCase {
  Future<Either<Failure, void>> statusIncrement(OrderEntity entity);
}
