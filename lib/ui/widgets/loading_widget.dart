import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.size = 80.0,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSquareCircle(
        color: kMainColor,
        size: size,
        duration: const Duration(milliseconds: 800),
      ),
    );
  }
}
