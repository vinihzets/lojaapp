import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_event.dart';
import 'package:lojaapp/features/cart/presentation/widgets/cart_price_tile.dart';
import 'package:lojaapp/features/cart/presentation/widgets/items_cart_tile_widget.dart';
import 'package:lojaapp/features/cart/presentation/widgets/discount_card_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.event.add(CartEventGetItemsCart(
      context,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Meu Carrinho'),
          centerTitle: true,
        ),
        body: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: BlocScreenBuilder(
              stream: bloc.state,
              builder: (state) {
                if (state is BlocEmptyState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.remove_shopping_cart_outlined,
                        size: 80.0,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 70.0),
                        child: Text(
                          'O seu carrinho esta Vazio',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          onPressed: () =>
                              bloc.event.add(CartEventNavigate(context)),
                          child: const Text('Adicionar Produtos'))
                    ],
                  );
                } else if (state is BlocStableState) {
                  CartStableData data = state.data;

                  return ListView(
                    children: [
                      Column(
                        children: data.products
                            .map((e) => CartTileWidget(
                                  product: e,
                                  bloc: bloc,
                                ))
                            .toList(),
                      ),
                      DiscountCard(bloc: bloc, value: data.getTotalPrice()),
                      CartPriceTile(
                        subTotal: data.getTotalPrice(),
                        buy: () {},
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              }),
        ));
  }
}
