import '../../../../core/failure/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../datasources/login_datasource.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImp implements LoginRepository {
  LoginDataSource loginDataSource;

  LoginRepositoryImp(this.loginDataSource);

  @override
  Future<Either<Failure, UserCredential>> login(String email, String password) {
    return loginDataSource.login(email, password);
  }
}
