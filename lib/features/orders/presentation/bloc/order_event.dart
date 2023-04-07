import 'package:flutter/material.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';

abstract class OrderEvent {}

class OrderEventGet implements OrderEvent {
  BuildContext context;

  OrderEventGet(this.context);
}

class OrderEventNavigate implements OrderEvent {
  BuildContext context;
  String routeName;
  OrderEventNavigate(this.context, this.routeName);
}

class OrderEventNavigateThenArgs implements OrderEvent {
  BuildContext context;
  String routeName;
  Object args;

  OrderEventNavigateThenArgs(this.context, this.routeName, this.args);
}

class OrderInitPlatformVersion implements OrderEvent {
  BuildContext context;

  OrderInitPlatformVersion(this.context);
}

class OrderGeneratePreferences implements OrderEvent {
  BuildContext context;
  OrderEntity entity;

  OrderGeneratePreferences(this.context, this.entity);
}
