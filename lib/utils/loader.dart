import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, this.size}) : super(key: key);
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 100,
      child: Lottie.asset('assets/loader.json'),
    );
  }
}

Center getErrorWidget(String error) {
  return Center(
    child: Text(
      error,
    ),
  );
}
