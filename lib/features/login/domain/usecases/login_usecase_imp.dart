import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/login/domain/repositories/login_repository.dart';
import 'package:lojaapp/features/login/domain/usecases/login_usecase.dart';

class LoginUseCaseImp implements LoginUseCase {
  LoginRepository loginRepository;

  LoginUseCaseImp(this.loginRepository);

  @override
  Future<Either<Failure, UserCredential>> login(String email, String password) {
    return loginRepository.login(email, password);
  }
}
