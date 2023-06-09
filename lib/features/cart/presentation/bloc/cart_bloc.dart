import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../../data/dto/cart_products_dto.dart';
import '../../domain/usecases/add_cart_order_usecase.dart';
import '../../domain/usecases/get_cart_item_usecase.dart';
import '../../domain/usecases/dec_product_usecase.dart';
import '../../domain/usecases/discount_cart_items_usecase.dart';
import '../../domain/usecases/inc_product_usecase.dart';
import '../../domain/usecases/remove_item_cart_usecase.dart';
import 'cart_event.dart';
import '../../../../main.dart';

class SnackMixin {
  void showSnack(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}

class NavigateMixin {
  void navigateRemoveUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void navigateThenUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}

class CartStableData {
  final List<CartProductsDto> products;
  final double discount;
  getSubTotalPrice() {
    double price = 0.0;
    for (CartProductsDto c in products) {
      price += double.parse(c.quantity.toString()) * double.parse(c.price);
    }
    return price;
  }

  getTotalPrice(double subTotal, double discount) {
    final sum = subTotal - discount;
    return sum;
  }

  CartStableData(this.products, this.discount);
}

class CartBloc with SnackMixin, NavigateMixin {
  GetItemsCart getItemsUseCase;
  RemoveItemCartUseCase removeItemCartUseCase;
  IncProductUseCase incProductUseCase;
  DecProductUseCase decProductUseCase;
  DiscountCardItemUseCase discountCardItemUseCase;
  AddCartOrderUseCase addCartOrderUseCase;

  CartBloc(
    this.getItemsUseCase,
    this.removeItemCartUseCase,
    this.incProductUseCase,
    this.decProductUseCase,
    this.discountCardItemUseCase,
    this.addCartOrderUseCase,
  ) {
    _event = StreamController();
    _state = StreamController();
    _cache = [];
    _event.stream.listen(_mapListenEvent);
  }

  late StreamController<CartEvent> _event;
  Sink<CartEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late List<CartProductsDto> _cache;

  dispatchEvent(CartEvent event) {
    _event.add(event);
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }

  _mapListenEvent(CartEvent event) {
    if (event is CartEventGetItemsCart) {
      getItemsCart(event.context);
    } else if (event is CartEventRemoveItem) {
      removeItemToCart(event.context, event.id);
    } else if (event is CartEventIncItem) {
      incItem(event.context, event.cartProductsDto);
    } else if (event is CartEventDecItem) {
      decItem(event.context, event.cartProductsDto);
    } else if (event is CartEventNavigate) {
      navigateRemoveUntil(event.context, event.routeName);
    } else if (event is CartEventCouponVerify) {
      couponVerify(event.context, event.coupon, event.totalValue);
    } else if (event is CartEventCouponExists) {
      discountApply(event.totalValue, event.percent);
    } else if (event is CartEventCreateOrder) {
      addCartToOrder(
          event.context, event.productsPrice, event.discount, event.totalPrice);
    }
  }

  _dispatchStable(
    List<CartProductsDto> products,
    double discount,
  ) {
    _cache = products;
    if (_cache.isEmpty) {
      _dispatchState(BlocEmptyState());
    } else {
      _dispatchState(BlocStableState(data: CartStableData(_cache, discount)));
    }
  }

  getItemsCart(BuildContext context) async {
    final getItemsCartRequest = await getItemsUseCase();

    getItemsCartRequest.fold((l) {
      showSnack(context, l.message, Colors.red);
    }, (r) {
      _dispatchStable(r, 0.0);
    });
  }

  incItem(BuildContext context, CartProductsDto cartProductsDto) async {
    final incRequest = await incProductUseCase.incProduct(cartProductsDto);

    incRequest.fold((l) {
      showSnack(context, l.message, Colors.red);
    }, (r) {
      _dispatchStable(_cache, 0.0);
    });
  }

  decItem(BuildContext context, CartProductsDto cartProductsDto) async {
    final decRequest = await decProductUseCase.decProduct(cartProductsDto);

    decRequest.fold((l) {
      showSnack(context, l.message, Colors.red);
    }, (r) {
      _dispatchStable(_cache, 0.0);
    });
  }

  removeItemToCart(BuildContext context, String id) async {
    final removeitemRequest = await removeItemCartUseCase(id);

    removeitemRequest.fold((l) {
      showSnack(context, l.message, Colors.red);
    }, (r) {
      _cache.removeWhere((element) => element.id == id);
      if (_cache.isEmpty) {
        _dispatchState(BlocEmptyState());
      } else {
        _dispatchStable(_cache, 0.0);
      }
    });
  }

  couponVerify(BuildContext context, String coupon, double totalValue) async {
    final addCoupon = await discountCardItemUseCase.couponVerify(coupon);

    addCoupon.fold((l) {
      showSnack(context, l.message, Colors.red);
    }, (r) {
      if (r.exists) {
        showSnack(context, 'Cupom Existente', Colors.green);

        bool applyCupom = true;
        int percent = r.get('cupom');
        dispatchEvent(CartEventCouponExists(totalValue, percent, applyCupom));
      } else {
        showSnack(context, 'Cupom Inexistente', Colors.red);
      }
    });
  }

  discountApply(double totalPrice, num percent) {
    double totalDiscount = 0.0;
    totalDiscount = (totalPrice / 100 * percent);
    _dispatchStable(_cache, totalDiscount);
  }

  addCartToOrder(BuildContext context, double productsPrice, double discount,
      double totalPrice) async {
    final orderRequest = await addCartOrderUseCase.addOrder(
        _cache, productsPrice, discount, totalPrice);

    orderRequest.fold((l) {
      showSnack(context, l.message, Colors.red);
    }, (r) {
      showSnack(context, 'Pedido realizado com sucesso', Colors.green);
      navigateRemoveUntil(context, gConsts.orderScreen);
    });
  }
}
