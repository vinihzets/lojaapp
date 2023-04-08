import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/architeture/bloc_builder.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../../../../core/utils/payment_translator.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../widgets/build_status_widgets_order_screen.dart';
import '../../../../main.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderBloc bloc;
  final String publicKey = 'TEST-41fa6116-fe1d-411d-9a2b-fb19403303ae';

  @override
  void initState() {
    bloc = GetIt.I.get();

    bloc.event.add(OrderEventGet(context));
    bloc.initPlatformVersion(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                                onExpansionChanged: (value) {
                                  if (value == true) {
                                    if (e.status < 2) {
                                      bloc.event.add(
                                          OrderGeneratePreferences(context, e));
                                    }
                                  }
                                },
                                tilePadding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                childrenPadding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                title: Text(
                                  'Pedido: ${e.orderId}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  const Text(
                                    'Status do Pedido: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStatusCircleWidgets(
                                          '1',
                                          'Aguardando Pagamento',
                                          e.status.toInt(),
                                          1),
                                      Container(
                                        height: 1,
                                        width: 10.0,
                                        color: Colors.grey,
                                      ),
                                      buildStatusCircleWidgets(
                                          '2',
                                          'Pagamento Aprovado',
                                          e.status.toInt(),
                                          2),
                                      Container(
                                        height: 1,
                                        width: 10,
                                        color: Colors.grey,
                                      ),
                                      buildStatusCircleWidgets('3',
                                          'Transporte', e.status.toInt(), 3),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  const Text(
                                    'Descricao: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                      'Desconto R\$ ${e.discount.toStringAsFixed(2)}'),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    'Valor total R\$ ${e.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  const Text(
                                    'Items: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                      children: e.products
                                          .map((e) => Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      '${e.quantity} x ${e.name} R\$ ${e.priceUnity} tamanho: ${e.size}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 4.0,
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList()),
                                  BlocScreenBuilder(
                                      stream: bloc.statePayment,
                                      builder: (state) {
                                        if (state is BlocStableState) {
                                          final PaymentEntity result =
                                              state.data;
                                          final preferenceKey =
                                              result.preferenceId;

                                          return _buildPayment(context, e, bloc,
                                              publicKey, preferenceKey);
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      }),
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

_buildPayment(BuildContext context, OrderEntity e, OrderBloc bloc,
    String publicKey, String preferenceKey) {
  if (e.status.toInt() < 2) {
    return Center(
      child: TextButton(
        onPressed: () async {
          bloc.event.add(OrderGeneratePreferences(context, e));

          PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
            publicKey,
            preferenceKey,
          );

          if (result.status == 'approved') {
            bloc.event.add(OrderEventStatusIncrement(context, e));
          } else if (result.status == null) {
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(PaymentTranslator.translator(result.status))));
          }
        },
        child: const Text('Realizar Pagamento'),
      ),
    );
  } else {
    return Container();
  }
}
