import 'package:filter/data_model/country_state.dart';
import 'package:flutter/material.dart';
import 'package:filter/ui/common/app_colors.dart';
import 'package:filter/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'notice_sheet_model.dart';

class NoticeSheet extends StackedView<NoticeSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;
  const NoticeSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NoticeSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: 500,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceTiny,
          Text(
            request.description!,
            style: const TextStyle(fontSize: 14, color: kcMediumGrey),
            maxLines: 3,
            softWrap: true,
          ),
          verticalSpaceLarge,
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search States',
            ),
            onChanged: viewModel.filter,
          ),
          verticalSpaceMedium,
          Expanded(
            child: Builder(
              builder: (context) {
                if (viewModel.data == null || viewModel.data!.isEmpty) {
                  return const Center(
                    child: Text('No State(s) found'),
                  );
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final CountryState? state =
                        viewModel.data?.elementAt(index);
                    return ListTile(
                      title: Text(state?.name ?? '--'),
                      onTap: () {
                        completer!(
                          SheetResponse(
                            confirmed: true,
                            data: state,
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: viewModel.data?.length ?? 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  NoticeSheetModel viewModelBuilder(BuildContext context) => NoticeSheetModel();
}
