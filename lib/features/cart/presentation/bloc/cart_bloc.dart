import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/core/model/cart_model.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/usecases/get_cart_item_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/dec_product_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/discount_cart_items_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/inc_product_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/remove_item_cart_usecase.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_event.dart';
import 'package:lojaapp/main.dart';

class SnackMixin {
  void showSnack(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}

class NavigateMixin {
  void navigate(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(gConsts.homeScreen, (route) => false);
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
  CartModel cartModel;

  CartBloc(
      this.getItemsUseCase,
      this.removeItemCartUseCase,
      this.incProductUseCase,
      this.decProductUseCase,
      this.discountCardItemUseCase,
      this.cartModel) {
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
      navigate(event.context);
    } else if (event is CartEventCouponVerify) {
      couponVerify(event.context, event.coupon, event.totalValue);
    } else if (event is CartEventCouponExists) {
      discountApply(event.totalValue, event.percent);
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
    for (final product in _cache) {
      totalDiscount = (totalPrice / 100 * percent);
    }
    _dispatchStable(_cache, totalDiscount);
  }
}
