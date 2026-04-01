import 'package:flutter/material.dart';
import 'package:pizza_app/components/separator.dart';
import 'package:pizza_app/screens/cart/components/order_row.dart';

class OrderInfo extends StatelessWidget {
  final double subTotal;
  final double delivery;
  final double total;

  const OrderInfo({
    super.key,
    required this.subTotal,
    required this.delivery,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Info',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            OrderRow(
              label: 'Subtotal:',
              value: '\$${subTotal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 5),
            OrderRow(
              label: 'Delivery:',
              value: '\$${delivery.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 10),
            MySeparator(color: Theme.of(context).dividerColor),
            const SizedBox(height: 20),
            OrderRow(
              label: 'Total:',
              value: '\$${total.toStringAsFixed(2)}',
              isBold: true,
            ),
            const SizedBox(height: 20),
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement checkout
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Checkout Now',
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
