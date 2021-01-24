import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/assignment/assignment_new.dart';
import 'package:emma_mobile/ui/screens/main/empty_block.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class _AssignItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 63.h,
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 16.w),
              child: Row(
                children: [
                  AppIcons.measurementDefault(height: 44.h, width: 44.h),
                  Padding(
                    padding: EdgeInsets.only(left: 9.w),
                    child: Text(
                      'eei ie19e102e109',
                      style: AppTypography.font14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.c3B4047,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 52.w,
                    height: 32.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.cD1D1D6, width: 1.w),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: AppIcons.accept(
                          width: 20.w,
                          height: 14.h,
                          color: AppColors.cD1D1D6,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 32.h,
            color: AppColors.cFF3B30.withOpacity(0.1),
            child: Center(
              child: Text(
                '42342',
                style: AppTypography.font12.copyWith(color: AppColors.cFF3B30),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AssignData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.only(top: 12.h),
    //   child: Column(
    //     children: [
    //       _AssignItem(),
    //       Padding(
    //         padding: EdgeInsets.only(top: 16.h),
    //         child: DefaultContainer(
    //           minHeight: 125.h,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.only(top: 16.h, left: 12.w),
    //                 child: Text(
    //                   'Вы выполнили 0 из 10 назначений',
    //                   style: AppTypography.font14.copyWith(
    //                     color: AppColors.c3B4047,
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(
    //                   top: 12.h,
    //                   bottom: 18.h,
    //                   left: 12.w,
    //                   right: 12.w,
    //                 ),
    //                 child: Container(
    //                   height: 10.h,
    //                   width: 264.w,
    //                   decoration: const BoxDecoration(
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(10),
    //                     ),
    //                     color: AppColors.cECEFFB,
    //                   ),
    //                   clipBehavior: Clip.antiAlias,
    //                   child: Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: AnimatedContainer(
    //                       width: 264.w / 10,
    //                       height: 10.h,
    //                       duration: Constants.buttonDuration,
    //                       curve: Curves.linear,
    //                       decoration: const BoxDecoration(
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(10),
    //                         ),
    //                         color: AppColors.c00ACE3,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               ColoredBox(
    //                 color: AppColors.cEBEEF3,
    //                 child: SizedBox(
    //                   width: MediaQuery.of(context).size.width,
    //                   height: 1.h,
    //                 ),
    //               ),
    //               GestureDetector(
    //                 behavior: HitTestBehavior.opaque,
    //                 child: SizedBox(
    //                   height: 50.h,
    //                   child: Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 12.w),
    //                     child: Row(
    //                       children: [
    //                         AppIcons.calendar(),
    //                         Padding(
    //                           padding: EdgeInsets.only(left: 8.w),
    //                           child: Text(
    //                             'История назначений',
    //                             style: AppTypography.font12.copyWith(
    //                               color: AppColors.c3B4047,
    //                             ),
    //                           ),
    //                         ),
    //                         const Spacer(),
    //                         AppIcons.arrowRight(),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          child: EmptyBlockMain(
            icon: AppIcons.prescriptionsInactive(),
            title: 'Здесь будут показываться ваши\nближайшие назначения',
            buttonTitle: 'Добавить первое назначение',
            onTap: () {
              navigatorPush(context, AssignmentNewScreen());
            },
          ),
        ),
        DefaultContainer(
          minHeight: 98.h,
          child: Center(
            child: SizedBox(
              width: 224.w,
              child: Text(
                'Как только вы начнете выполнять назначения, здесь появится ваш прогресс выполнения.',
                style: AppTypography.font12.copyWith(
                  color: AppColors.c9B9B9B,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
