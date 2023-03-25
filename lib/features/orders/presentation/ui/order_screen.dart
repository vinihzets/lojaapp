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
import 'package:lojaapp/main.dart';

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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () =>
                bloc.event.add(OrderEventNavigate(context, gConsts.homeScreen)),
            icon: const Icon(Icons.chevron_left_outlined)),
      ),
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
                                  Text(
                                      'Preco total: R\$ ${e.totalPrice.toStringAsFixed(2)}'),
                                  Column(
                                      children: e.products
                                          .map((e) => Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Valor unitario: ${e.priceUnity}',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.network(
                                                            e.image,
                                                            width: 80,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                          'item: ${e.name}',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'quantidade: ${e.quantity}'
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'tamanho: ${e.size}',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
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
