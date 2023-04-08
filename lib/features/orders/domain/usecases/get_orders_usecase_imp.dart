import '../entities/order_entity.dart';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/order_repository.dart';
import 'get_orders_usecase.dart';

class GetOrdersUseCaseImp implements GetOrdersUseCase {
  OrderRepository orderRepository;

  GetOrdersUseCaseImp(this.orderRepository);

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() {
    return orderRepository.getOrders();
  }
}
