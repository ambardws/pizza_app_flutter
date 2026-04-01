import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza_app/screens/home/views/home_screen.dart';

class EmptyOrders extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const EmptyOrders(
    this.screenWidth,
    this.screenHeight,
    { super.key });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.cube_box,
                size: screenWidth * 0.15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Text(
              'You haven\'t placed any orders yet.\nStart ordering your favorite pizzas!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            ElevatedButton(
              onPressed: () {
                // TODO: Pindah ke tab home
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Order Now',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
