import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_state.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/ui/components/measurement_app_bar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementDetailScreen extends StatelessWidget {
  final Measurement item;

  const MeasurementDetailScreen({
    @required this.item,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MeasurementDetailBloc(measurement: item),
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: Builder(
          builder: (context) {
            final bloc = context.bloc<MeasurementDetailBloc>();
            return BlocBuilder<MeasurementDetailBloc, MeasurementDetailState>(
              builder: (_, __) {
                return Column(
                  children: [
                    MeasurementDetailAppBar(
                      title: item.longTitle,
                      showHour: item is Pulse,
                      initialType: bloc.type,
                      onChange: bloc.setDateType,
                    ),
                  ],
                );
              }
            );
          }
        ),
      ),
    );
  }
}
