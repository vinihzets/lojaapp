import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';

class PaymentDto extends PaymentEntity {
  PaymentDto(super.preferenceId, super.clientId, super.dateCreated);

  factory PaymentDto.fromJson(Map<String, dynamic> map) {
    return PaymentDto(map['id'], map['client_id'], map['date_created']);
  }
}
