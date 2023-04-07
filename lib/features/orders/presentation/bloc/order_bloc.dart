import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/orders/data/dtos/payment_dto.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/domain/entities/payment_entity.dart';
import 'package:lojaapp/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:lojaapp/features/orders/domain/usecases/mercado_pago_usecase.dart';
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

  navigateThenArgs(BuildContext context, String routeName, Object args) {
    Navigator.of(context).pushNamed(routeName, arguments: args);
  }
}

class OrderBloc with HudMixins {
  GetOrdersUseCase getOrdersUseCase;
  MercadoPagoUseCase mercadoPagoUseCase;

  String publicKey = '';
  String preferenceId = '';
  OrderBloc(this.getOrdersUseCase, this.mercadoPagoUseCase) {
    _event = StreamController();
    _state = StreamController();

    _statePayment = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
  }

  late StreamController<OrderEvent> _event;
  Sink<OrderEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<BlocState> _statePayment;
  Stream<BlocState> get statePayment => _statePayment.stream;

  dispatchEvent(OrderEvent event) {
    _event.add(event);
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }

  dispatchStatePayment(BlocState state) {
    _statePayment.add(state);
  }

  _mapListenEvent(OrderEvent event) {
    if (event is OrderEventGet) {
      getOrders(event.context);
    } else if (event is OrderEventNavigate) {
      navigate(event.context, event.routeName);
    } else if (event is OrderInitPlatformVersion) {
      initPlatformVersion(event.context);
    } else if (event is OrderGeneratePreferences) {
      createPreferences(event.context, event.entity);
    } else if (event is OrderEventNavigateThenArgs) {
      navigateThenArgs(event.context, event.routeName, event.args);
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

  initPlatformVersion(
    BuildContext context,
  ) async {
    final platformRequest = await mercadoPagoUseCase.initPlatformState();
    platformRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      return r;
    });
  }

  createPreferences(BuildContext context, OrderEntity e) async {
    final preferencesRequest = await mercadoPagoUseCase.createaPreference(e);
    preferencesRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      dispatchStatePayment(BlocStableState(data: r));
    });
  }
}
