import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const EmmaAppBar(
            title: 'Выбор даты назначения',
            leading: BackLeading(text: 'Назначения'),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: SizedBox(
                  width: 288.w,
                  child: Center(
                    child: Text('Календарь в разработке'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
