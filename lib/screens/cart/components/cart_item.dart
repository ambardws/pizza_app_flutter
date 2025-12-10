import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/cart/components/quantity_button.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItem({
    super.key,
    required this.cart,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(3, 3)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPizzaImage(),
            const SizedBox(width: 20),
            Expanded(child: _buildCartDetails()),
          ],
        ),
      ),
    );
  }

  Widget _buildPizzaImage() {
    return Image.network(
      cart.pizza.picture,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/1.png', width: 100, height: 100);
      },
    );
  }

  Widget _buildCartDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cart.pizza.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '\$${cart.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        _buildQuantityControls(),
      ],
    );
  }

  Widget _buildQuantityControls() {
    return Row(
      children: [
        QuantityButton(
          icon: CupertinoIcons.minus,
          onPressed: () {
            onDecrement();
          },
        ),
        const SizedBox(width: 10),
        Text('${cart.quantity}'),
        const SizedBox(width: 10),
        QuantityButton(
          icon: CupertinoIcons.plus,
          onPressed: () {
            onIncrement();
          },
        ),
      ],
    );
  }
}
