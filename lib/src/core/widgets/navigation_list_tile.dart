import 'package:flutter/material.dart';

class NavigationListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const NavigationListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
