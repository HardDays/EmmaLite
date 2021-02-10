import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/sync/sync_cubit.dart';
import 'package:emma_mobile/ui/screens/sync/sync_finish_screen.dart';
import 'package:emma_mobile/ui/screens/sync/sync_loading_screen.dart';
import 'package:emma_mobile/ui/screens/sync/sync_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SyncInfoScreen extends StatelessWidget {
  const SyncInfoScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SyncScreen(
      text: 'activateHintAppleHealthSubTitle'.tr,
      buttonTitle: 'furtherButtonTitle'.tr,
      onNext: () {
        final bloc = context.read<SyncCubit>();
        bloc.init().then((value) async {
          final bloc = context.read<MeasurementCubit>();
          bloc.reload();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SyncFinishScreen(),
            ),
          );

          // хз как нормально это все реализовать
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(
          //     backgroundColor: AppColors.c4CD964,
          //     content: Row(
          //       children: [
          //         Text('Данные синхронизированы.',
          //           style: TextStyle(
          //             fontSize: Constants.textSize12,
          //             color: Colors.white
          //           ),
          //         )
          //       ],
          //     ),
          //   )
          // );
          // showModalBottomSheet(
          //   context: context,
          //   backgroundColor: Colors.transparent,
          //   barrierColor: Colors.transparent,
          //   builder: (context) => Container(
          //     color: AppColors.c4CD964,
          //     padding: const EdgeInsets.all(18),
          //     child: Row(
          //       children: [
          //         Text('Данные синхронизированы.',
          //           style: TextStyle(
          //             fontSize: Constants.textSize12,
          //             color: Colors.white
          //           ),
          //         )
          //       ],
          //     )
          //   )
          // );
          // await Future.delayed(Duration(seconds: 2));
          // Navigator.pop(context);
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SyncLoadingScreen(),
          ),
        );
      },
    );
  }
}
