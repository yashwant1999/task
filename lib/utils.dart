import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

class CustomSwitcher extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  const CustomSwitcher({
    Key? key,
    required bool toggle,
    required this.firstChild,
    required this.secondChild,
  })  : _toggle = toggle,
        super(key: key);

  final bool _toggle;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: _toggle ? secondChild : firstChild,
    );
  }
}
