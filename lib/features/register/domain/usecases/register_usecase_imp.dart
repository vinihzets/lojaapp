import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failure/failure.dart';
import '../repositories/register_repository.dart';
import 'register_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCaseImp implements RegisterUseCase {
  RegisterRepository registerRepository;

  RegisterUseCaseImp(this.registerRepository);

  @override
  Future<Either<Failure, UserCredential>> register(
      String email, String password) {
    return registerRepository.register(email, password);
  }
}
