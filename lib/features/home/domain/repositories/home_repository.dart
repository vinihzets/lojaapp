import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> signOut();
}
