import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterRepository {
  Future<Either<Failure, UserCredential>> register(
      String email, String password);
}
