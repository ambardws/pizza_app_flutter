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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(3, 3)),
        ],
      ),
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Info',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
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
            MySeparator(color: Colors.grey.shade300),
            const SizedBox(height: 20),
            OrderRow(
              label: 'Total:',
              value: '\$${total.toStringAsFixed(2)}',
              isBold: true,
            ),
            const SizedBox(height: 20),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement checkout
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Checkout Now',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
