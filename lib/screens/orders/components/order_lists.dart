import 'package:flutter/material.dart';
import 'package:pizza_app/screens/orders/components/order_card.dart';

class OrderLists extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final double screenWidth;
  final double screenHeight;

  const OrderLists(
    this.screenWidth,
    this.screenHeight,
    this.orders,
  );

   Widget build(
    BuildContext context,
  ) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Text(
              'My Orders',
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),

        // List orders
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final order = orders[index];
              return OrderCard(order);
            },
            childCount: orders.length,
          ),
        ),
      ],
    );
  }

}