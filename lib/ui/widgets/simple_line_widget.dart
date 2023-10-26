import 'package:flutter/material.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';

class SimpleLineWidget extends StatelessWidget {
  const SimpleLineWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    int? intValue;

    double? doubleValue = double.tryParse(value);

    if (doubleValue != null) {
      if (doubleValue - doubleValue.floor() == 0) {
        intValue = doubleValue.toInt();
      }
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width:
                  UIHelper.deviceWidth(context) > UIHelper.deviceHeight(context)
                      ? UIHelper.deviceWidth(context) * 0.24
                      : UIHelper.deviceWidth(context) * 0.32,
              child: Text(
                title,
                style: const TextStyle(
                  color: kTextMainColor,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(
              width: UIHelper.responsiveExtraBigSpacing(context),
            ),
            Flexible(
              child: Text(
                intValue != null
                    ? intValue.toString().padLeft(2, '0')
                    : doubleValue != null
                        ? double.tryParse(value)!.toStringAsFixed(2)
                        : value,
                style: const TextStyle(
                  color: kTextSecondaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: UIHelper.responsiveSmallSpacing(context),
        ),
      ],
    );
  }
}
