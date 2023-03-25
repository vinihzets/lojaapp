import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/orders/data/dtos/order_dto.dart';
import 'package:lojaapp/features/orders/data/dtos/products_dto.dart';
import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';
import 'package:lojaapp/features/orders/presentation/bloc/order_bloc.dart';
import 'package:lojaapp/features/orders/presentation/bloc/order_event.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.dispatchEvent(OrderEventGet(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocScreenBuilder(
          stream: bloc.state,
          builder: (state) {
            if (state is BlocEmptyState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.playlist_add_check,
                    size: 90,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Nenhuma compra realizada',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            } else if (state is BlocStableState) {
              List<OrderEntity> orders = state.data;
              inspect(orders);

              return ListView(
                children: orders
                    .map((e) => Column(
                          children: [
                            Card(
                              child: ExpansionTile(
                                title: Text(
                                  'Id: ${e.orderId}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  Text('Preco total: ${e.totalPrice}'),
                                  Column(
                                      children: e.products
                                          .map((e) => Row(
                                                children: [
                                                  Image.network(
                                                    e.image,
                                                    width: 40,
                                                  ),
                                                  Text(e.name),
                                                  Text(e.quantity.toString()),
                                                  Text(e.size),
                                                ],
                                              ))
                                          .toList())
                                ],
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
