import 'package:flutter/material.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import 'package:lojaapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:lojaapp/features/home/presentation/bloc/home_event.dart';

class NewsProductTile extends StatelessWidget {
  final ProductEntity product;
  final HomeBloc bloc;

  const NewsProductTile({required this.product, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: () =>
              bloc.event.add(HomeEventNavigateToDetails(context, product)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.images.first,
                  fit: BoxFit.cover,
                  width: 180,
                  height: 180,
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
