import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emma_mobile/utils/utils.dart';

class Constants {
  Constants._();

  static final dynamicSize = ScreenUtil();

  static const Duration buttonDuration = Duration(milliseconds: 300);
  static const Duration requestDuration = Duration(seconds: 3);

  static String passwordRegex = r'(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&()?,./\|*№;:]).{8,}$';
  static String emailRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+';

  static String mockImage = 'https://avatars.mds.yandex.net/get-kinopoisk-post-img/1345014/95e44cfe0abaddb03e43181d31a9f788/960x540';

  static final double textSize4 = dynamicSize.setSp(4);
  static final double textSize6 = dynamicSize.setSp(6);
  static final double textSize8 = dynamicSize.setSp(18);
  static final double textSize10 = dynamicSize.setSp(10);
  static final double textSize12 = dynamicSize.setSp(12);
  static final double textSize13 = dynamicSize.setSp(13);
  static final double textSize14 = dynamicSize.setSp(14);
  static final double textSize15 = dynamicSize.setSp(15);
  static final double textSize16 = dynamicSize.setSp(16);
  static final double textSize17 = dynamicSize.setSp(17);
  static final double textSize18 = dynamicSize.setSp(18);
  static final double textSize19 = dynamicSize.setSp(19);
  static final double textSize20 = dynamicSize.setSp(20);
  static final double textSize22 = dynamicSize.setSp(22);
  static final double textSize24 = dynamicSize.setSp(24);
  static final double textSize26 = dynamicSize.setSp(26);
  static final double textSize28 = dynamicSize.setSp(28);
  static final double textSize32 = dynamicSize.setSp(32);
  static final double textSize34 = dynamicSize.setSp(34);
  static final double textSize38 = dynamicSize.setSp(38);
  static final double textSize48 = dynamicSize.setSp(48);
  static final double textSize72 = dynamicSize.setSp(72);
}
