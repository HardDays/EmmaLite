import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/screens/measurement/empty_measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmmaAppBar(
        titleText: 'Измерения',
        centerTitle: true,
      ),
      body: BlocBuilder<MeasurementCubit, MeasurementState>(
        builder: (context, state) {
          //todo
          return EmptyMeasurements();
          // if (state.measurementList?.payload?.isNotEmpty == true) {
          //   return ListView.builder(
          //     itemBuilder: (context, index) => MeasurementListItem(measurements[index]),
          //     itemCount: measurements.length,
          //   );
          // } else if (state.measurementList?.payload?.isEmpty == true) {
          //   return const EmptyMeasurements();
          // }
          // return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
