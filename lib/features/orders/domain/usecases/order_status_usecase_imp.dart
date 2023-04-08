import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';
import 'order_status_usecase.dart';

class OrderStatusUseCaseImp implements OrderStatusUseCase {
  OrderRepository orderRepository;

  OrderStatusUseCaseImp(this.orderRepository);

  @override
  Future<Either<Failure, void>> statusIncrement(OrderEntity entity) {
    return orderRepository.statusIncrement(entity);
  }
}
