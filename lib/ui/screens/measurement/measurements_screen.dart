import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/screens/measurement/empty_measurements.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<MeasurementCubit>();
    return Scaffold(
      body: Column(
        children: [
          const EmmaAppBar(
            title: 'Измерения',
          ),
          BlocBuilder<MeasurementCubit, MeasurementState>(
            builder: (_, state) {
              if (bloc.data.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (_, i) {
                    return MeasurementListItem(item: bloc.data[i]);
                  },
                  itemCount: bloc.data.length,
                );
              }
              return const EmptyMeasurements();
            },
          ),
        ],
      ),
    );
  }
}
