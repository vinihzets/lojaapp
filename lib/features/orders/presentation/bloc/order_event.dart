import 'package:flutter/material.dart';

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

class OrderInitPlatformVersion implements OrderEvent {
  BuildContext context;

  OrderInitPlatformVersion(this.context);
}

class OrderGeneratePreferences implements OrderEvent {
  String name;

  OrderGeneratePreferences(this.name);
}
