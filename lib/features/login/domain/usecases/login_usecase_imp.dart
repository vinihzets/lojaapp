import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failure/failure.dart';
import '../repositories/login_repository.dart';
import 'login_usecase.dart';

class LoginUseCaseImp implements LoginUseCase {
  LoginRepository loginRepository;

  LoginUseCaseImp(this.loginRepository);

  @override
  Future<Either<Failure, UserCredential>> login(String email, String password) {
    return loginRepository.login(email, password);
  }
}
