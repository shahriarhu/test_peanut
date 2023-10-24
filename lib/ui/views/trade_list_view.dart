import 'package:flutter/material.dart';
import 'package:test_peanut/core/view_models/trade_list_view_model.dart';
import 'package:test_peanut/ui/views/base_view.dart';

class TradeListView extends StatelessWidget {
  const TradeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TradeListViewModel>(
      onModelReady: (model) async {
        await model.getOpenTrades();
      },
      builder: (context, model, child) => const Scaffold(
        body: SafeArea(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
