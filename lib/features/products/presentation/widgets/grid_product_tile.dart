import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_bloc.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_event.dart';

class GridProductTile extends StatelessWidget {
  final ProductsEntity product;
  final ProductsBloc bloc;

  const GridProductTile({required this.product, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: () =>
              bloc.event.add(ProductsEventNavigateDetails(context, product)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.images.first,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  product.name,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  product.price,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
