import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaAppBar extends StatelessWidget {
  final String title;
  final Widget leading;
  final Widget trailing;

  const EmmaAppBar({
    Key key,
    this.title,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(minHeight: 100.h),
          color: AppColors.cFFFFFF,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                 if (leading != null)
                   leading,
                  const Spacer(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h, left: 16.w),
                child: Text(
                  title,
                  style: AppTypography.font22.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
        ColoredBox(
          color: AppColors.cE6E9EB,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 1.h,
          ),
        )
      ],
    );
  }
}
