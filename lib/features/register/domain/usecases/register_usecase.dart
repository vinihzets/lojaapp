import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterUseCase {
  Future<Either<Failure, UserCredential>> register(
      String email, String password);
}
