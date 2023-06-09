import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';

class NoParams {}

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call({required Input params});
}
