import 'package:bsccs/custom_widgets/adbox_widget.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_repository/shared_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseItemWidget extends StatelessWidget {
  const CourseItemWidget(this._item, {Key? key}) : super(key: key);
  final FreeCourse _item;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius / 2);
    final CsInterstitialAd csInterstitialAd = CsInterstitialAd();
    return Card(
      color: CustomColors.actionColor,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: cardBorderRadius,
            ),
            child: Utils.isSvgFile(_item.courseImage)
                ? SvgPicture.network(
                    _item.courseImage,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    _item.courseImage,
                    errorBuilder: (ctx, object, trace) => Container(
                      color: CustomColors.primaryColor,
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _item.courseName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).paddingForOnly(left: 70),
                  Text(
                    _item.courseFrom,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).paddingForOnly(left: 70, top: 2),
                  Text(
                    _item.courseDescription,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ).paddingForOnly(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                ],
              ).paddingWithSymmetry(horizontal: 10, vertical: 10),
              Positioned(
                top: -10,
                left: 10,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: cardBorderRadius,
                  ),
                  child: Utils.isSvgFile(_item.courseProviderImage)
                      ? SvgPicture.network(
                          _item.courseProviderImage,
                        ).paddingForAll(5)
                      : Image.network(
                          _item.courseProviderImage,
                          errorBuilder: (ctx, object, trace) => Container(),
                        ),
                ),
              )
            ],
          ),
        ],
      ).asButton(
        onTap: () {
          csInterstitialAd.showAdd(
            onAddDismiss: () => launchUrl(
              Uri.parse(_item.courseLink),
              mode: LaunchMode.externalApplication,
            ),
          );
        },
        borderRadius: cardBorderRadius,
      ),
    );
  }
}
