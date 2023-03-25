import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:lojaapp/features/orders/presentation/bloc/order_event.dart';

mixin HudMixins {
  showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}

class OrderBloc with HudMixins {
  GetOrdersUseCase getOrdersUseCase;

  OrderBloc(this.getOrdersUseCase) {
    _event = StreamController();
    _state = StreamController();

    _event.stream.listen(_mapListenEvent);
  }

  late StreamController<OrderEvent> _event;
  Sink<OrderEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  dispatchEvent(OrderEvent event) {
    _event.add(event);
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }

  _mapListenEvent(OrderEvent event) {
    if (event is OrderEventGet) {
      getOrders(event.context);
    } else if (event is OrderEventNavigate) {
      navigate(event.context, event.routeName);
    }
  }

  getOrders(BuildContext context) async {
    final orderRequest = await getOrdersUseCase.getOrders();
    orderRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      if (r.isEmpty) {
        _dispatchState(BlocEmptyState());
      } else {
        _dispatchState(BlocStableState(data: r));
      }
    });
  }
}
