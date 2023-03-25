import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/orders/data/datasources/order_datasources.dart';
import 'package:lojaapp/features/orders/data/dtos/order_dto.dart';
import 'package:lojaapp/features/orders/data/dtos/products_dto.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';

class OrderDataSourcesRemoteImp implements OrderDataSources {
  AuthService auth;
  DatabaseService databaseService;

  OrderDataSourcesRemoteImp(this.auth, this.databaseService);

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      final database = databaseService.db;
      final userId = auth.auth.currentUser!.uid;

      final documents = await database
          .collection('orders')
          .doc(userId)
          .collection('order')
          .get();

      final list =
          documents.docs.map((e) => OrderDto.fromJson(e.data())).toList();

      return Right(list);
    } on FirebaseException catch (e) {
      return Left(RemoteFailure(message: e.message ?? ''));
    }
  }
}
