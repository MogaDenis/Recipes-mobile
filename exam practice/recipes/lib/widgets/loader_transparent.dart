import 'package:flutter/material.dart';

class LoaderTransparent extends StatelessWidget {
  const LoaderTransparent({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: const Center(
        child: SizedBox(
          height: 60.0,
          width: 60.0,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 5.0),
        ),
      ),
    );
  }
}
