import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/view_models/dashboard_view_model.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';
import 'package:test_peanut/ui/views/base_view.dart';
import 'package:test_peanut/ui/widgets/animated_profile_button_widget.dart';
import 'package:test_peanut/ui/widgets/loading_widget.dart';
import 'package:test_peanut/ui/widgets/simple_line_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      onModelReady: (model) async {
        await model.getAccountInformation();
        await model.getLastFourNumbersPhone();
      },
      builder: (context, model, child) => Scaffold(
        body: model.state == ViewState.idle
            ? SafeArea(
                child: Padding(
                  /// Checking the screen orientation

                  padding:
                      EdgeInsets.all(UIHelper.responsiveBigPadding(context)),
                  child: UIHelper.deviceWidth(context) >
                          UIHelper.deviceHeight(context)

                      /// Landscape view
                      ? Row(
                          children: [
                            Entry.scale(
                              duration: const Duration(milliseconds: 400),
                              child: SizedBox(
                                width: UIHelper.deviceWidth(context) * 0.36,
                                child: Column(
                                  children: [
                                    AnimatedProfileButtonWidget(
                                      buttonName: 'Your account',
                                      onClick: () {
                                        model.isAccountSelected = true;
                                      },
                                      isAccountSelected:
                                          model.isAccountSelected,
                                    ),
                                    AnimatedProfileButtonWidget(
                                      buttonName: 'Your balance',
                                      onClick: () {
                                        model.isAccountSelected = false;
                                      },
                                      isAccountSelected:
                                          !model.isAccountSelected,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: UIHelper.deviceWidth(context) * 0.58,
                              child: Stack(
                                children: [
                                  Entry.all(
                                    visible: model.isAccountSelected,
                                    duration: const Duration(milliseconds: 400),
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          SimpleLineWidget(
                                            title: 'Name',
                                            value: model.userProfile.name!,
                                          ),
                                          SimpleLineWidget(
                                            title: 'Phone',
                                            value: model.lastFourNumbersPhone,
                                          ),
                                          SimpleLineWidget(
                                            title: 'Verification',
                                            value: model
                                                .userProfile.verificationLevel
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Address',
                                            value: model.userProfile.address!,
                                          ),
                                          SimpleLineWidget(
                                            title: 'City',
                                            value: model.userProfile.city!,
                                          ),
                                          SimpleLineWidget(
                                            title: 'Zipcode',
                                            value: model.userProfile.zipCode!,
                                          ),
                                          SimpleLineWidget(
                                            title: 'Country',
                                            value: model.userProfile.country!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Entry.offset(
                                    visible: !model.isAccountSelected,
                                    duration: const Duration(milliseconds: 400),
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          SimpleLineWidget(
                                            title: 'Balance',
                                            value: model.userProfile.balance
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Currency',
                                            value: model.userProfile.currency
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Current Trades',
                                            value: model
                                                .userProfile.currentTradesCount
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Current Trades Volume',
                                            value: model
                                                .userProfile.currentTradesVolume
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Equity',
                                            value: model.userProfile.equity
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Free Margin',
                                            value: model.userProfile.freeMargin
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Swap Free',
                                            value: model.userProfile.isSwapFree
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Leverage',
                                            value: model.userProfile.leverage
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Open Trade Availability',
                                            value: model
                                                .userProfile.isAnyOpenTrades
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Trade Type',
                                            value: model.userProfile.type
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Total Trades',
                                            value: model
                                                .userProfile.totalTradesCount
                                                .toString(),
                                          ),
                                          SimpleLineWidget(
                                            title: 'Total Trades Volume',
                                            value: model
                                                .userProfile.totalTradesVolume
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        )
                      :

                      /// Portrait view
                      Column(
                          children: [
                            Entry.scale(
                              duration: const Duration(milliseconds: 400),
                              child: Column(
                                children: [
                                  AnimatedProfileButtonWidget(
                                    buttonName: 'Your account',
                                    onClick: () {
                                      model.isAccountSelected = true;
                                    },
                                    isAccountSelected: model.isAccountSelected,
                                  ),
                                  AnimatedProfileButtonWidget(
                                    buttonName: 'Your balance',
                                    onClick: () {
                                      model.isAccountSelected = false;
                                    },
                                    isAccountSelected: !model.isAccountSelected,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Entry.all(
                                  visible: model.isAccountSelected,
                                  duration: const Duration(milliseconds: 400),
                                  child: Column(
                                    children: [
                                      SimpleLineWidget(
                                        title: 'Name',
                                        value: model.userProfile.name!,
                                      ),
                                      SimpleLineWidget(
                                        title: 'Phone',
                                        value: model.lastFourNumbersPhone,
                                      ),
                                      SimpleLineWidget(
                                        title: 'Verification',
                                        value: model
                                            .userProfile.verificationLevel
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Address',
                                        value: model.userProfile.address!,
                                      ),
                                      SimpleLineWidget(
                                        title: 'City',
                                        value: model.userProfile.city!,
                                      ),
                                      SimpleLineWidget(
                                        title: 'Zipcode',
                                        value: model.userProfile.zipCode!,
                                      ),
                                      SimpleLineWidget(
                                        title: 'Country',
                                        value: model.userProfile.country!,
                                      ),
                                    ],
                                  ),
                                ),
                                Entry.offset(
                                  visible: !model.isAccountSelected,
                                  duration: const Duration(milliseconds: 400),
                                  child: Column(
                                    children: [
                                      SimpleLineWidget(
                                        title: 'Balance',
                                        value: model.userProfile.balance
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Currency',
                                        value: model.userProfile.currency
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Current Trades',
                                        value: model
                                            .userProfile.currentTradesCount
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Current Trades Volume',
                                        value: model
                                            .userProfile.currentTradesVolume
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Equity',
                                        value:
                                            model.userProfile.equity.toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Free Margin',
                                        value: model.userProfile.freeMargin
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Swap Free',
                                        value: model.userProfile.isSwapFree
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Leverage',
                                        value: model.userProfile.leverage
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Open Trade Availability',
                                        value: model.userProfile.isAnyOpenTrades
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Trade Type',
                                        value:
                                            model.userProfile.type.toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Total Trades',
                                        value: model
                                            .userProfile.totalTradesCount
                                            .toString(),
                                      ),
                                      SimpleLineWidget(
                                        title: 'Total Trades Volume',
                                        value: model
                                            .userProfile.totalTradesVolume
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                ),
              )
            : const LoadingWidget(),
      ),
    );
  }
}
