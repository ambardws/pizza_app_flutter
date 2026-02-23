import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileMenuItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ProfileMenuItems({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: screenWidth * 0.03),
            ),
            SizedBox(width: screenWidth * 0.03),

            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.w600)),
                SizedBox(height: screenWidth * 0.008),
                Text(subtitle, style: TextStyle(fontSize: screenWidth * 0.028, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6))),
              ],
            )),

            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: screenWidth * 0.04,
              ),
          ],
        ),
      ),
    );
  }
  
}