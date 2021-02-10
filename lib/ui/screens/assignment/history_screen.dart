import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/assign/assign_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/screens/assignment/assignments_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AssignHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Column(
        children: [
          EmmaAppBar(
            title: 'История назначений',
            leading: BackLeading(
              text: 'differenceBackTextLabel'.tr.capitalizeFirst,
            ),
          ),
          Expanded(
            child: BlocBuilder<AssignBloc, AssignState>(
              builder: (_, __) {
                return AssignHistory();
              },
            ),
          )
        ],
      ),
    );
  }
}
