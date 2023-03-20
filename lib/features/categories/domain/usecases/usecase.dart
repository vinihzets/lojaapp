import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call();
}
