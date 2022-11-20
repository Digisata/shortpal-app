import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final double width;
  final double height;
  final Function onPressed;
  final List<Color> colors;

  const PrimaryButton({
    Key? key,
    required this.child,
    required this.colors,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
