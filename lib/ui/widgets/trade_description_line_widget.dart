import 'package:flutter/material.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';

class TradeDescriptionLineWidget extends StatelessWidget {
  const TradeDescriptionLineWidget({
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$title :',
          style: const TextStyle(
            fontSize: 12,
          ),
          textAlign: TextAlign.end,
        ),
        SizedBox(
          width: UIHelper.responsiveSmallSpacing(context),
        ),
        Flexible(
          child: Text(
            intValue != null
                ? intValue.toString().padLeft(2, '0')
                : doubleValue != null
                    ? double.tryParse(value)!.toStringAsFixed(2)
                    : value,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
