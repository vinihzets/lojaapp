import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/dtos/products_dto.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  late ProductsBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    super.initState();
  }

  String size = '';

  @override
  Widget build(BuildContext context) {
    ProductsDto product =
        ModalRoute.of(context)!.settings.arguments as ProductsDto;

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(),
        body: ListView(
          children: [
            AspectRatio(
                aspectRatio: 0.9,
                child: CarouselSlider(
                  items: product.images.map((e) {
                    return Image.network(e, fit: BoxFit.cover);
                  }).toList(),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 1.0,
                    initialPage: 0,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Tamanho',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 34,
                    child: GridView(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 0.5),
                      scrollDirection: Axis.horizontal,
                      children: product.sizes
                          .map((e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    size = e;
                                    product.sizeProduct = e;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: e == size
                                              ? Colors.blue
                                              : Colors.grey,
                                          width: 3.0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  alignment: Alignment.center,
                                  child: Text(e),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 380,
                    child: ElevatedButton(
                        onPressed: size == ''
                            ? null
                            : () => bloc.event
                                .add(ProductsEventAddToCart(context, product)),
                        child: const Text('Adicionar ao carrinho')),
                  ),
                  const Text(
                    'Descricao',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(product.description)
                ],
              ),
            )
          ],
        ));
  }
}
