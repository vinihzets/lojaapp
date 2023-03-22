import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class RemoveItemCartUseCase {
  Future<Either<Failure, void>> call(String id);
}
