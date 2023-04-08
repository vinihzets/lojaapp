import '../../../../core/failure/failure.dart';
import '../datasources/register_datasources.dart';
import '../../domain/repositories/register_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepositoryImp implements RegisterRepository {
  RegisterDataSource registerDataSource;

  RegisterRepositoryImp(this.registerDataSource);

  @override
  Future<Either<Failure, UserCredential>> register(
      String email, String password) {
    return registerDataSource.register(email, password);
  }
}
