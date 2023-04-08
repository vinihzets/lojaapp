import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> signOut();
}
