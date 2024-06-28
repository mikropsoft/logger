import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? const Color.fromARGB(255, 0, 0, 0)
          : const Color.fromARGB(255, 255, 255, 255),
      child: const Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 106, 26, 227),
        ),
      ),
    );
  }
}
