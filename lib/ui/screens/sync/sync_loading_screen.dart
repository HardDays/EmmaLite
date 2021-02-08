import 'dart:io';

import 'package:emma_mobile/ui/components/buttons/emma_flat_button.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SyncLoadingScreen extends StatelessWidget {

  SyncLoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 75.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 120.h, bottom: 120.h),
              child: SvgPicture.asset(Platform.isAndroid ? 'assets/icons/google.svg' : 'assets/icons/apple.svg',
              ),
            ),
            Text('',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Constants.textSize16,
                fontWeight: FontWeight.w700,
                color: AppColors.c3B4047
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              child: Text(Platform.isAndroid ? 'Выполняется импорт ваших данных из приложения Google fit' : 'Выполняется импорт ваших данных из приложения Здоровье',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.c3B4047
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: EmmaFlatButton(
                title: 'Свернуть',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> NavigatorScreen()));
                }
              ),
            )
          ],
        ),
      )
    );
  }
}
