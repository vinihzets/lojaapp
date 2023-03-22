import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_event.dart';

class DiscountCard extends StatelessWidget {
  CartBloc bloc;

  DiscountCard({required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: const Icon(Icons.card_giftcard_outlined),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onFieldSubmitted: (text) {
                bloc.event.add(CartEventAddDiscount(context, text));
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
