import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';
import 'package:test_peanut/ui/shared/ui_helpers.dart';
import 'package:test_peanut/ui/widgets/loading_widget.dart';

class PromoWidget extends StatelessWidget {
  const PromoWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.imageUrl,
    required this.promoText,
  });

  final VoidCallback onTap;
  final String title;
  final String imageUrl;
  final String promoText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kScaffoldBackgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            UIHelper.responsiveBigPadding(context),
          ),
          child: Column(
            children: [
              Text(title),
              SizedBox(
                height: UIHelper.responsiveSmallSpacing(context),
              ),
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const LoadingWidget(
                  size: 32,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: kMainColor,
                ),
              ),
              SizedBox(
                height: UIHelper.responsiveSmallSpacing(context),
              ),
              Text(
                promoText,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kMainColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
