import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../datasources/order_datasources.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImp implements OrderRepository {
  OrderDataSources orderDataSources;

  OrderRepositoryImp(this.orderDataSources);

  @override
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
