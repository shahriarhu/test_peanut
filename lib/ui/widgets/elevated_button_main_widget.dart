import 'package:flutter/material.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';

class ElevatedButtonMainWidget extends StatelessWidget {
  const ElevatedButtonMainWidget({
    Key? key,
    required this.buttonName,
    this.icon,
    required this.onClickListener,
    this.isSmall = false,
  }) : super(key: key);

  final String buttonName;
  final IconData? icon;
  final VoidCallback? onClickListener;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: UIHelper.deviceWidth(context) > UIHelper.deviceHeight(context)
            ? UIHelper.deviceWidth(context) * 0.6
            : UIHelper.deviceWidth(context),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          backgroundColor: kMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: onClickListener,
        child: Padding(
          padding: icon != null
              ? EdgeInsets.symmetric(
                  vertical: UIHelper.responsiveBigPadding(context))
              : EdgeInsets.symmetric(
                  vertical: UIHelper.responsiveBigPadding(context) + 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: icon != null
                ? [
                    Icon(
                      icon,
                      size: isSmall ? 20 : 24,
                    ),
                    SizedBox(
                      width: UIHelper.responsiveSmallSpacing(context),
                    ),
                    Text(
                      buttonName,
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: isSmall ? 12 : 14,
                        fontWeight: isSmall ? FontWeight.w500 : FontWeight.w600,
                      ),
                    ),
                  ]
                : [
                    Text(
                      buttonName,
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: isSmall ? 12 : 14,
                        fontWeight: isSmall ? FontWeight.w500 : FontWeight.w600,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
