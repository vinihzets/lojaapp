import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/domain/repositories/order_repository.dart';
import 'package:lojaapp/features/orders/domain/usecases/order_status_usecase.dart';

class OrderStatusUseCaseImp implements OrderStatusUseCase {
  OrderRepository orderRepository;

  OrderStatusUseCaseImp(this.orderRepository);

  Future<Either<Failure, void>> statusIncrement(OrderEntity entity) {
    return orderRepository.statusIncrement(entity);
  }
}
