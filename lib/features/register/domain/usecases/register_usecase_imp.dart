import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/register/domain/repositories/register_repository.dart';
import 'package:lojaapp/features/register/domain/usecases/register_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCaseImp implements RegisterUseCase {
  RegisterRepository registerRepository;

  RegisterUseCaseImp(this.registerRepository);

  Future<Either<Failure, UserCredential>> register(
      String email, String password) {
    return registerRepository.register(email, password);
  }
}
