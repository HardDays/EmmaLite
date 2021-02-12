import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/assign/assign_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/assign/empty_or_expired.dart';
import 'package:emma_mobile/ui/components/assign_item.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AssignDateScreen extends StatelessWidget {
  final DateTime date;

  const AssignDateScreen({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AssignBloc>();
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Column(
        children: [
          EmmaAppBar(
            title: date.assignScreenFormatter,
            leading: BackLeading(
              text: 'differenceBackTextLabel'.tr.capitalizeFirst,
            ),
          ),
          Expanded(
            child: BlocBuilder<AssignBloc, AssignState>(
              builder: (_, __) {
                final tasks = bloc.getTaskInDay(date: date);
                if (tasks.isEmpty) {
                  return Center(
                    child: EmptyOrExpired(
                      child: AppIcons.prescriptionsInactive(
                        width: 44.w,
                        height: 44.w,
                      ),
                      text: 'noPrescriptionsPlanTitle'.tr.replaceAll(
                            RegExp('#DATE#'),
                            date.assignScreenFormatter.toLowerCase(),
                          ),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: tasks.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemBuilder: (_, i) {
                    return AssignItem(task: tasks[i]);
                  },
                  separatorBuilder: (_, __) {
                    return Padding(padding: EdgeInsets.only(top: 8.h));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
