import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/orders/components/empty_orders.dart';
import 'package:pizza_app/screens/orders/components/order_lists.dart';

/// Orders screen - menampilkan riwayat pesanan
/// TODO: Integrate dengan orders BLoC
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Placeholder data - nanti diganti dengan real data dari BLoC
    final List<Map<String, dynamic>> orders = [];

    return Scaffold(
      body: SafeArea(
        child: orders.isEmpty
            ? EmptyOrders(screenWidth, screenHeight)
            : OrderLists(screenWidth, screenHeight, orders),
      ),
    );
  }
}
