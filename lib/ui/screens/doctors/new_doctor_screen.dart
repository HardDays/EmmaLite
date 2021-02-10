import 'package:emma_mobile/bloc/doctors_screen/doctors_bloc.dart';
import 'package:emma_mobile/bloc/new_doctor_bloc/new_doctor_bloc.dart';
import 'package:emma_mobile/bloc/new_doctor_bloc/new_doctor_state.dart';
import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewDoctorScreen extends StatelessWidget {
  final Doctor doctor;

  const NewDoctorScreen({Key key, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          EmmaAppBar(
            title: doctor == null ? 'titleAddNewDoctor'.tr : doctor.name,
            leading: BackLeading(text: 'mainDoctorListTitle'.tr),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocProvider(
                create: (_) => NewDoctorBloc(initialDoctor: doctor),
                child: Builder(
                  builder: (context) {
                    final bloc = context.bloc<NewDoctorBloc>();
                    return BlocBuilder<NewDoctorBloc, NewDoctorState>(
                      builder: (_, __) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: DefaultContainer(
                                child: InputTextField(
                                  onChange: bloc.setName,
                                  haveFormatter: false,
                                  initialValue: doctor?.name,
                                  type: TextInputType.text,
                                  label: 'doctorNameText'.tr,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: DefaultContainer(
                                child: InputTextField(
                                  onChange: bloc.setEmail,
                                  haveFormatter: false,
                                  initialValue: doctor?.email,
                                  type: TextInputType.emailAddress,
                                  formatRegExp: RegExp(Constants.emailRegex),
                                  label: 'titleEmail'.tr,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: DefaultContainer(
                                child: InputTextField(
                                  maxLines: null,
                                  maxLength: 150,
                                  onChange: bloc.setComment,
                                  initialValue: doctor?.comment,
                                  haveFormatter: false,
                                  type: TextInputType.text,
                                  label: 'titleComment'.tr,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 168.h)),
                            if ((doctor != null && bloc.haveChanges) ||
                                doctor == null)
                              EmmaFilledButton(
                                width: 288.w,
                                title: 'saveButtonText'.tr,
                                isActive: bloc.canSave,
                                onTap: () {
                                  if (doctor == null) {
                                    context
                                        .bloc<DoctorsBloc>()
                                        .saveDoctor(bloc.doctor);
                                  } else {
                                    context
                                        .bloc<DoctorsBloc>()
                                        .updateDoctor(bloc.doctor);
                                  }
                                  Navigator.of(context).pop();
                                },
                              ),
                            if (doctor != null)
                              Padding(
                                padding: EdgeInsets.only(top: 24.h),
                                child: EmmaFilledButton(
                                  width: 288.w,
                                  title: 'removeExecutionLabel'.tr,
                                  activeColor: AppColors.cFF3B30,
                                  isActive: true,
                                  onTap: () {
                                    context
                                        .bloc<DoctorsBloc>()
                                        .deleteDoctor(bloc.doctor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            Padding(padding: EdgeInsets.only(bottom: 24.h)),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
