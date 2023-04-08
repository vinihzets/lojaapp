import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/order_entity.dart';
import '../entities/payment_entity.dart';
import '../repositories/order_repository.dart';
import 'mercado_pago_usecase.dart';

class MercadoPagoUseCaseImp implements MercadoPagoUseCase {
  OrderRepository orderRepository;

  MercadoPagoUseCaseImp(this.orderRepository);

  @override
  Future<Either<Failure, String>> initPlatformState() {
    return orderRepository.initPlatformState();
  }

  @override
  Future<Either<Failure, PaymentEntity>> createaPreference(OrderEntity entity) {
    return orderRepository.createPreference(entity);
  }
}
