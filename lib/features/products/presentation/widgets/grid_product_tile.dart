import 'package:flutter/material.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';

class GridProductTile extends StatelessWidget {
  final ProductEntity product;
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
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
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
