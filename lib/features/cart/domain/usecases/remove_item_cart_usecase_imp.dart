import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/remove_item_cart_usecase.dart';

class RemoveItemCartUseCaseImp implements RemoveItemCartUseCase {
  CartRepository cartRepository;

  RemoveItemCartUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return cartRepository.removeCartItems(id);
  }
}
