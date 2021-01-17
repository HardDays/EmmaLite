import 'package:emma_mobile/bloc/new_measurement_bloc/new_measurement_bloc.dart';
import 'package:emma_mobile/bloc/new_measurement_bloc/new_measurement_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/components/textfields/emm_text_field.dart';
import 'package:emma_mobile/utils/date_utils.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementNewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeasurementNewScreenState();
}

class _MeasurementNewScreenState extends State<MeasurementNewScreen> {
  TextEditingController _type;
  TextEditingController _date;
  TextEditingController _measures;
  bool _isFormValid = false;

  @override
  void initState() {
    _type = TextEditingController();
    _date = TextEditingController();
    _measures = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _type.dispose();
    _date.dispose();
    _measures.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmmaAppBar(
        titleText: 'Измерение',
        centerTitle: true,
        leading: const BackButton(color: AppColors.c00ACE3),
      ),
      body: BlocProvider(
        create: (_) => NewMeasurementBloc(),
        child: Builder(
          builder: (context) {
            return BlocBuilder<NewMeasurementBloc, NewMeasurementState>(
              builder: (_, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HSpace(20),
                      EmmaTextField(
                        textEditingController: _type,
                        withPicker: true,
                        labelText: 'Тип измерения',
                        // onTap: () => showDataPicker<MeasurementType>(
                        //   context,
                        //   [], //todo
                        //   // state.measurementTypes?.payload?.toList(),
                        //   (measurement) => {
                        //     _validateForm(),
                        //     context
                        //         .read<MeasurementCubit>()
                        //         .setCurrentMeasurementType(measurement),
                        //     _type.text = measurement.name,
                        //   },
                        //   'Тип измерения',
                        // ),
                      ),
                      const HSpace(20),
                      EmmaTextField(
                        textEditingController: _date,
                        withPicker: true,
                        labelText: 'Дата и время',
                        onTap: () => showCustomDatePicker(
                          context,
                              (date) {
                            _validateForm();
                            _date.text = dateTimeToString(date);
                          },
                          'Дата и время',
                        ),
                      ),
                      const HSpace(20),
                      EmmaTextField(
                        textEditingController: _measures,
                        onChanged: (text) {
                          _validateForm();
                        },
                        labelText: 'Показатели',
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: EmmaFilledButton(
                          isActive: _isFormValid,
                          title: 'Сохранить',
                          // onTap: () => {
                          //   context.read<MeasurementCubit>().saveMeasurement(
                          //       _date.text, _type.text, _measures.text),
                          // },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }

  void _validateForm() {
    setState(() => _isFormValid = _date.text.isNotEmpty &&
        _type.text.isNotEmpty &&
        _measures.text.isNotEmpty);
  }
}
