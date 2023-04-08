import 'package:flutter/material.dart';
import '../../data/dto/cart_products_dto.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class CartTileWidget extends StatefulWidget {
  final CartProductsDto product;
  final CartBloc bloc;

  const CartTileWidget({required this.product, required this.bloc, super.key});

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: 120,
          child: Image.network(widget.product.images.first),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              Text(
                'Tamanho: ${widget.product.size}',
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                'R\$ ${widget.product.price}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: widget.product.quantity < 2
                          ? null
                          : () {
                              widget.bloc.event.add(
                                  CartEventDecItem(context, widget.product));
                            },
                      icon: const Icon(Icons.remove)),
                  Text(widget.product.quantity.toString()),
                  IconButton(
                      onPressed: () {
                        widget.bloc.event
                            .add(CartEventIncItem(context, widget.product));
                      },
                      icon: const Icon(Icons.add)),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent)),
                      onPressed: () {
                        widget.bloc.event.add(
                            CartEventRemoveItem(context, widget.product.id));
                      },
                      child: const Text('Remover'))
                ],
              ),
            ],
          ),
        ))
      ],
    );
  }
}
