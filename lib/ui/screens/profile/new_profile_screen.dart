
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:flutter/material.dart';

class NewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SmallAppBar(
            leading: BackLeading(text: ''),
            title: 'Новый профиль',
          )
        ],
      ),
    );
  }
}
