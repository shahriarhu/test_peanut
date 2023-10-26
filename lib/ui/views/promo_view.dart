import 'package:flutter/material.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/view_models/promo_view_model.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';
import 'package:test_peanut/ui/views/base_view.dart';
import 'package:test_peanut/ui/widgets/loading_widget.dart';
import 'package:test_peanut/ui/widgets/promo_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoView extends StatelessWidget {
  const PromoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<PromoViewModel>(
      onModelReady: (model) async {
        await model.getPromo();
      },
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: model.state == ViewState.idle
              ? Padding(
                  padding:
                      EdgeInsets.all(UIHelper.responsiveBigPadding(context)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Promotions',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(
                          height: UIHelper.responsiveMediumSpacing(context),
                        ),
                        PromoWidget(
                          onTap: () async {
                            final Uri appUrl = Uri.parse(
                                model.promos!.forexCopy!.link.toString());
                            await canLaunchUrl(appUrl)
                                ? await launchUrl(
                                    appUrl,
                                    mode: LaunchMode.externalApplication,
                                  )
                                : throw ('Could not launch $appUrl');
                          },
                          title: model.promos!.forexCopy!.text.toString(),
                          imageUrl: model.promos!.forexCopy!.image.toString(),
                          promoText:
                              model.promos!.forexCopy!.buttonText.toString(),
                        ),
                        PromoWidget(
                          onTap: () async {
                            final Uri appUrl = Uri.parse(
                                model.promos!.ferrari!.link.toString());
                            await canLaunchUrl(appUrl)
                                ? await launchUrl(
                                    appUrl,
                                    mode: LaunchMode.externalApplication,
                                  )
                                : throw ('Could not launch $appUrl');
                          },
                          title: model.promos!.ferrari!.text.toString(),
                          imageUrl: model.promos!.ferrari!.image.toString(),
                          promoText:
                              model.promos!.ferrari!.buttonText.toString(),
                        ),
                        PromoWidget(
                          onTap: () async {
                            final Uri appUrl = Uri.parse(
                                model.promos!.tether!.link.toString());
                            await canLaunchUrl(appUrl)
                                ? await launchUrl(
                                    appUrl,
                                    mode: LaunchMode.externalApplication,
                                  )
                                : throw ('Could not launch $appUrl');
                          },
                          title: model.promos!.tether!.text.toString(),
                          imageUrl: model.promos!.tether!.image.toString(),
                          promoText:
                              model.promos!.tether!.buttonText.toString(),
                        ),
                        PromoWidget(
                          onTap: () async {
                            final Uri appUrl = Uri.parse(
                                model.promos!.luckyDeposit!.link.toString());
                            await canLaunchUrl(appUrl)
                                ? await launchUrl(
                                    appUrl,
                                    mode: LaunchMode.externalApplication,
                                  )
                                : throw ('Could not launch $appUrl');
                          },
                          title: model.promos!.luckyDeposit!.text.toString(),
                          imageUrl:
                              model.promos!.luckyDeposit!.image.toString(),
                          promoText:
                              model.promos!.luckyDeposit!.buttonText.toString(),
                        ),
                      ],
                    ),
                  ),
                )
              : const LoadingWidget(),
        ),
      ),
    );
  }
}
