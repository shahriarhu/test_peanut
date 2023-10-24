import 'package:flutter/material.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/view_models/dashboard_view_model.dart';
import 'package:test_peanut/ui/views/base_view.dart';
import 'package:test_peanut/ui/widgets/loading_widget.dart';

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
                child: Column(
                  children: [
                    Text(model.userProfile.name!),
                    Text(model.userProfile.address!),
                    Text(model.userProfile.currency.toString()),
                    Text(model.userProfile.balance.toString()),
                    Text(model.userProfile.currentTradesVolume.toString()),
                    Text(model.userProfile.isSwapFree.toString()),
                    Text(model.userProfile.extensionData.toString()),
                    Text(model.userProfile.name!),
                    Text(model.userProfile.name!),
                    Text(model.userProfile.name!),
                    Text(model.userProfile.name!),
                    Text(model.userProfile.name!),
                    Text(model.userProfile.name!),
                    Text(model.userProfile.name!),
                    Text(model.userProfile.name!),
                    Text(model.lastFourNumbersPhone),
                  ],
                ),
              )
            : const LoadingWidget(),
      ),
    );
  }
}
