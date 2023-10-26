import 'package:flutter/material.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';

class AnimatedProfileButtonWidget extends StatelessWidget {
  const AnimatedProfileButtonWidget({
    super.key,
    required this.buttonName,
    required this.onClick,
    required this.isAccountSelected,
  });

  final String buttonName;
  final VoidCallback onClick;
  final bool isAccountSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onClick,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: UIHelper.deviceWidth(context),
            decoration: BoxDecoration(
              color: kScaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              boxShadow: isAccountSelected
                  ? [
                      BoxShadow(
                        offset: const Offset(-4, 0),
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: kTextSecondaryColor.withOpacity(0.4),
                      ),
                      // BoxShadow(
                      //   offset: Offset(UIHelper.deviceWidth(context) * 0.4, 0),
                      //   blurRadius: 2,
                      //   color: kWhiteColor,
                      // ),
                      // BoxShadow(
                      //   offset: Offset(UIHelper.deviceWidth(context) * 0.6, 0),
                      //   spreadRadius: 2,
                      //   blurRadius: 4,
                      //   color: kWhiteColor,
                      // ),
                      // BoxShadow(
                      //   offset: Offset(UIHelper.deviceWidth(context) * 0.8, 0),
                      //   spreadRadius: 4,
                      //   blurRadius: 8,
                      //   color: kWhiteColor,
                      // ),
                    ]
                  : null,
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(UIHelper.responsiveBigPadding(context) * 1.3),
              child: Text(
                buttonName,
                style: TextStyle(
                  color:
                      isAccountSelected ? kTextMainColor : kTextSecondaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: UIHelper.responsiveMediumSpacing(context),
        ),
      ],
    );
  }
}
