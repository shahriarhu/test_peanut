import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/view_models/trade_list_view_model.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';
import 'package:test_peanut/ui/views/base_view.dart';
import 'package:test_peanut/ui/widgets/loading_widget.dart';
import 'package:test_peanut/ui/widgets/trade_description_line_widget.dart';

class TradeListView extends StatelessWidget {
  const TradeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TradeListViewModel>(
      onModelReady: (model) async {
        await model.getOpenTrades();
        model.totalProfitCalculation();
      },
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: model.state == ViewState.idle
              ? Padding(
                  padding:
                      EdgeInsets.all(UIHelper.responsiveBigPadding(context)),

                  /// Checking the screen orientation

                  child: UIHelper.deviceWidth(context) >
                          UIHelper.deviceHeight(context)

                      /// Landscape view

                      ? Row(
                          children: [
                            Entry.scale(
                              child: SizedBox(
                                width: UIHelper.deviceWidth(context) * 0.32,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Open Trades',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text(
                                      'You total profit ${model.totalProfit.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: model.totalProfit < 0
                                                ? kRedSignalColor
                                                : kGreenSignalColor,
                                          ),
                                    ),
                                    SizedBox(
                                      height: UIHelper.responsiveMediumSpacing(
                                          context),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await model.getOpenTrades();
                                        model.totalProfitCalculation();
                                      },
                                      splashRadius: 24,
                                      icon: const Icon(
                                        Icons.refresh_rounded,
                                        color: kMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: UIHelper.responsiveMediumSpacing(context),
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                color: kMainColor,
                                onRefresh: () async {
                                  await model.getOpenTrades();
                                  model.totalProfitCalculation();
                                },
                                child: Entry.offset(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: model.userTrades.length,
                                    itemBuilder: (context, index) => Card(
                                      color: kScaffoldBackgroundColor,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            UIHelper.responsiveBigPadding(
                                                context)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.parseAndFormatDateTime(model
                                                  .userTrades[index].openTime
                                                  .toString()),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            TradeDescriptionLineWidget(
                                              title: 'Ticket',
                                              value: model
                                                  .userTrades[index].ticket
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              height: UIHelper
                                                  .responsiveSmallSpacing(
                                                      context),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  model.userTrades[index].symbol
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                                Text(
                                                  model.userTrades[index].volume
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                                Text(
                                                  model.userTrades[index]
                                                      .currentPrice
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                                Text(
                                                  model.userTrades[index].profit
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: UIHelper
                                                  .responsiveSmallSpacing(
                                                      context),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      TradeDescriptionLineWidget(
                                                        title: 'Open price',
                                                        value: model
                                                            .userTrades[index]
                                                            .openPrice
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Take Profit',
                                                        value: model
                                                            .userTrades[index]
                                                            .tp
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Stop Loss',
                                                        value: model
                                                            .userTrades[index]
                                                            .sl
                                                            .toString(),
                                                      ),
                                                      if (model
                                                              .userTrades[index]
                                                              .comment !=
                                                          null)
                                                        TradeDescriptionLineWidget(
                                                          title: 'Comment',
                                                          value: model
                                                                  .userTrades[
                                                                      index]
                                                                  .comment ??
                                                              '',
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      TradeDescriptionLineWidget(
                                                        title: 'Swaps',
                                                        value: model
                                                            .userTrades[index]
                                                            .swaps
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Digits',
                                                        value: model
                                                            .userTrades[index]
                                                            .digits
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Login',
                                                        value: model
                                                            .userTrades[index]
                                                            .login
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Type',
                                                        value: model
                                                            .userTrades[index]
                                                            .type
                                                            .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )

                      /// Portrait view

                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Entry.scale(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Open Trades',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Text(
                                        'You total profit ${model.totalProfit.toStringAsFixed(2)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: model.totalProfit < 0
                                                  ? kRedSignalColor
                                                  : kGreenSignalColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await model.getOpenTrades();
                                      model.totalProfitCalculation();
                                    },
                                    splashRadius: 24,
                                    icon: const Icon(
                                      Icons.refresh_rounded,
                                      color: kMainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: UIHelper.responsiveMediumSpacing(context),
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                color: kMainColor,
                                onRefresh: () async {
                                  await model.getOpenTrades();
                                  model.totalProfitCalculation();
                                },
                                child: Entry.offset(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: model.userTrades.length,
                                    itemBuilder: (context, index) => Card(
                                      color: kScaffoldBackgroundColor,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            UIHelper.responsiveBigPadding(
                                                context)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.parseAndFormatDateTime(model
                                                  .userTrades[index].openTime
                                                  .toString()),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            TradeDescriptionLineWidget(
                                              title: 'Ticket',
                                              value: model
                                                  .userTrades[index].ticket
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              height: UIHelper
                                                  .responsiveSmallSpacing(
                                                      context),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  model.userTrades[index].symbol
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                                Text(
                                                  model.userTrades[index].volume
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                                Text(
                                                  model.userTrades[index]
                                                      .currentPrice
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                                Text(
                                                  model.userTrades[index].profit
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: kMainColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: UIHelper
                                                  .responsiveSmallSpacing(
                                                      context),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      TradeDescriptionLineWidget(
                                                        title: 'Open price',
                                                        value: model
                                                            .userTrades[index]
                                                            .openPrice
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Take Profit',
                                                        value: model
                                                            .userTrades[index]
                                                            .tp
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Stop Loss',
                                                        value: model
                                                            .userTrades[index]
                                                            .sl
                                                            .toString(),
                                                      ),
                                                      if (model
                                                              .userTrades[index]
                                                              .comment !=
                                                          null)
                                                        TradeDescriptionLineWidget(
                                                          title: 'Comment',
                                                          value: model
                                                                  .userTrades[
                                                                      index]
                                                                  .comment ??
                                                              '',
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      TradeDescriptionLineWidget(
                                                        title: 'Swaps',
                                                        value: model
                                                            .userTrades[index]
                                                            .swaps
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Digits',
                                                        value: model
                                                            .userTrades[index]
                                                            .digits
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Login',
                                                        value: model
                                                            .userTrades[index]
                                                            .login
                                                            .toString(),
                                                      ),
                                                      TradeDescriptionLineWidget(
                                                        title: 'Type',
                                                        value: model
                                                            .userTrades[index]
                                                            .type
                                                            .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                )
              : const LoadingWidget(),
        ),
      ),
    );
  }
}
