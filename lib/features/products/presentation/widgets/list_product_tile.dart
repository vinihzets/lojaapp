import 'package:flutter/material.dart';
import '../../domain/entities/products_entity.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';

class ListProductTile extends StatelessWidget {
  final ProductsEntity product;
  final ProductsBloc bloc;

  const ListProductTile({required this.product, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () =>
            bloc.event.add(ProductsEventNavigateDetails(context, product)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Image.network(
                product.images.first,
                fit: BoxFit.cover,
                height: 250,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.price,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
