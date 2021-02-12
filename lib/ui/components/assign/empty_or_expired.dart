
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmptyOrExpired extends StatelessWidget {
  final Widget child;
  final String text;

  const EmptyOrExpired({Key key, this.text, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.h),
      child: BaseCenterWidget(
        child: child,
        text: text,
      ),
    );
  }
}

class BaseCenterWidget extends StatelessWidget {
  final Widget child;
  final String text;

  const BaseCenterWidget({Key key, this.child, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 4,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              )
            ],
          ),
          child: Center(child: child),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: SizedBox(
            width: 256.w,
            child: Text(
              text,
              style: AppTypography.font14.copyWith(
                color: AppColors.c9B9B9B,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}