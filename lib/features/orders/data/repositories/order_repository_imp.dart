import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/orders/data/datasources/order_datasources.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImp implements OrderRepository {
  OrderDataSources orderDataSources;

  OrderRepositoryImp(this.orderDataSources);

  Future<Either<Failure, List<OrderEntity>>> getOrders() {
    return orderDataSources.getOrders();
  }
}