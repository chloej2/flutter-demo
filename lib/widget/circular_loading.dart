import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      alignment: Alignment.center,
      child: const SizedBox(
          width: 60, height: 60, child: CircularProgressIndicator()),
    );
  }
}
