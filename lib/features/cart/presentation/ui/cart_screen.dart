import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_event.dart';
import 'package:lojaapp/features/cart/presentation/widgets/cart_tile_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc bloc;
  int index = 0;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.event.add(CartEventAddItem(
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
        body: BlocScreenBuilder(
            stream: bloc.state,
            builder: (state) {
              if (state is BlocStableState) {
                List<CartProductsDto> products = state.data;

                return ListView(
                  children: [
                    Column(
                      children: products
                          .map((e) => CartTileWidget(product: e))
                          .toList(),
                    )
                  ],
                );
              }
              return const SizedBox.shrink();
            }));
  }
}
