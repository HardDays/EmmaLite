import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/domain/model/measurements/measurement_type.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/buttons/text_back_button.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/components/textfields/emm_text_field.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentNewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AssignmentNewScreenState();
}

class _AssignmentNewScreenState extends State<AssignmentNewScreen> {
  final TextEditingController _type = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _measures = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmmaAppBar(
          titleText: 'Новое измерение',
          centerTitle: true,
          leading: const TextBackButton(title: 'Отменить'),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<MeasurementCubit, MeasurementState>(
      listener: (context, state) {
        if (state.isSaved?.payload == true) {
          navigatorPop(context);
        }
      },
      listenWhen: (current, previuos) => previuos != current,
      builder: (context, state) {
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
                onTap: () => showDataPicker<MeasurementType>(
                  context,
                  state.measurementTypes?.payload?.toList(),
                  (measurement) => {
                    _type.text = measurement.name,
                  },
                  'Тип измерения',
                ),
              ),
              const HSpace(20),
              EmmaTextField(
                textEditingController: _date,
                withPicker: true,
                labelText: 'Дата и время',
                onTap: () => showCustomDatePicker(
                    context,
                    (date) => {
                          _date.text = dateTimeToString(date),
                        },
                    'Дата и время'),
              ),
              const HSpace(20),
              EmmaTextField(
                textEditingController: _measures,
                onChanged: (text) => _measures.text = text,
                labelText: 'Показатели',
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: EmmaFilledButton(
                  // isActive: state.isFormValid,
                  title: 'Сохранить',
                  onTap: () => context
                      .read<MeasurementCubit>()
                      .saveMeasurement(_date.text, _type.text, _measures.text),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
