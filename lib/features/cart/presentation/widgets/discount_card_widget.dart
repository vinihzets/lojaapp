import 'package:flutter/material.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class DiscountCard extends StatelessWidget {
  final CartBloc bloc;
  final CartStableData data;
  const DiscountCard({required this.bloc, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final value = data.getSubTotalPrice();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: const Icon(Icons.card_giftcard_outlined),
        trailing: const Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onFieldSubmitted: (text) {
                bloc.event.add(CartEventCouponVerify(context, text, value));
              },
              decoration: const InputDecoration(
                  hintText: 'Digite seu Cupom',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
          ),
        ],
      ),
    );
  }
}
