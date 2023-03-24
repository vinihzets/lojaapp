import 'package:flutter/material.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_bloc.dart';

class CartPriceTile extends StatelessWidget {
  final VoidCallback buy;
  final CartStableData data;
  const CartPriceTile({required this.buy, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final subTotal = data.getSubTotalPrice();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                const Expanded(child: Text('Subtotal')),
                Text('R\$ ${subTotal.toStringAsFixed(2)}')
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Desconto')),
                Text('R\$ ${data.discount.toStringAsFixed(2)}')
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Expanded(child: Text('Entrega')),
                Text('R\$ 0.0')
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Expanded(child: Text('Total')),
                Text(
                  'R\$ ${data.getTotalPrice(subTotal, data.discount).toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.blue),
                )
              ],
            ),
            SizedBox(
                width: 360,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: buy,
                    child: const Text('Comprar')))
          ],
        ),
      ),
    );
  }
}
