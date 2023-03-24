import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/orders/domain/repositories/order_repository.dart';
import 'package:lojaapp/features/orders/domain/usecases/get_orders_usecase.dart';

class GetOrdersUseCaseImp implements GetOrdersUseCase {
  OrderRepository orderRepository;

  GetOrdersUseCaseImp(this.orderRepository);
  Future<Either<Failure, List<OrderEntity>>> getOrders() {
    return orderRepository.getOrders();
  }
}
