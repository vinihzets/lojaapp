import 'package:flutter/material.dart';

class HudMixins {
  navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  navigateRemoveUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  showSnack(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }

  navigateThenArgs(BuildContext context, String routeName, Object args) {
    Navigator.of(context).pushNamed(routeName, arguments: args);
  }
}
