import 'package:bsccs/cubit/practicals/practicals_cubit.dart';
import 'package:bsccs/custom_widgets/adbox_widget.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/models/list_wrapper.dart';
import 'package:bsccs/screens/practicals/widget/practicals_tab_item_widget.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_repository/shared_repo.dart';

class PracticalsTabScreen extends StatelessWidget {
  const PracticalsTabScreen({
    Key? key,
    required this.tabIndex,
    required this.onClicked,
  }) : super(key: key);

  final int tabIndex;
  final Function(Practical practical) onClicked;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticalsCubit, PracticalsState>(
      builder: (context, state) {
        List<AddWrapper>? addWrapperData = state.tabsData[tabIndex];
        if (addWrapperData == null) {
          return const CircularProgressIndicator().wrapCenter();
        }

        if (addWrapperData.isEmpty) {
          return const EmptyStateWidget();
        }
        return Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) =>
                  mapBookPageDataToWidget(addWrapperData[index], onClicked),
              itemCount: addWrapperData.length,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              physics: const BouncingScrollPhysics(),
            ).expanded(flex: 1),
            const CsBannerAd().paddingForOnly(bottom: 20)
          ],
        );
      },
    );
  }

  Widget mapBookPageDataToWidget(
    AddWrapper data,
    Function(Practical practical) onClicked,
  ) {
    if (data is AddWrapperData<ListWrapper<Practical>>) {
      return PracticalsTabItemWidget(
        practical: data.item,
        onClicked: onClicked,
      );
    }
    if (data is AddWrapperAd) {
      // return const AdWidget();
      return Container();
    }

    return Container(
      color: Colors.blue,
      width: 200,
      height: 100,
    );
  }
}
