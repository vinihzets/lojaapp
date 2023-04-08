import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/mercado_pago_usecase.dart';
import '../../domain/usecases/order_status_usecase.dart';
import 'order_event.dart';

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
  OrderStatusUseCase orderStatusUseCase;

  late List<OrderEntity> _cache;

  OrderBloc(
      this.getOrdersUseCase, this.mercadoPagoUseCase, this.orderStatusUseCase) {
    _event = StreamController();
    _state = StreamController();

    _statePayment = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
    _cache = [];
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
    } else if (event is OrderEventStatusIncrement) {
      statusOrderIncrement(event.context, event.entity);
    }
  }

  getOrders(BuildContext context) async {
    final orderRequest = await getOrdersUseCase.getOrders();
    orderRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      _cache = r;

      if (r.isEmpty) {
        _dispatchState(BlocEmptyState());
      } else {
        _dispatchState(BlocStableState(data: _cache));
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

  statusOrderIncrement(BuildContext context, OrderEntity entity) async {
    final statusIncrementRequest =
        await orderStatusUseCase.statusIncrement(entity);
    statusIncrementRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      _dispatchState(BlocStableState(data: _cache));
      // navigate(context, gConsts.homeScreen);
    });
  }
}
