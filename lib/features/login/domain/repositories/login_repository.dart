import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failure/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserCredential>> login(String email, String password);
}
