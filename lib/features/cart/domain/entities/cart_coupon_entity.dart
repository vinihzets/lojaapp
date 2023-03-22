import 'package:lojaapp/features/cart/domain/entities/cart_products_entity.dart';

class CartCouponEntity {
  String couponCode;
  int discountPercentage;

  CartCouponEntity(this.couponCode, this.discountPercentage);
}
