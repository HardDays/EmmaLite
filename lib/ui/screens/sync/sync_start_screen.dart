import 'dart:io';

import 'package:emma_mobile/ui/screens/sync/sync_info_screen.dart';
import 'package:emma_mobile/ui/screens/sync/sync_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyncStartScreen extends StatelessWidget {
  const SyncStartScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SyncScreen(
      title: Platform.isAndroid
          ? 'Активируйте Google fit'
          : 'Активируйте Apple Health',
      text:
          'Выполняйте импорт и экспорт данных, которые помогут вам получить более полное представление о вашем здоровье.',
      buttonTitle: 'Активировать',
      hasBack: false,
      hasCancel: true,
      onNext: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SyncInfoScreen(),
          ),
        );
      },
    );
  }
}
