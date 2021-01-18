/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  SvgGenImage get accept => const SvgGenImage('assets/icons/accept.svg');
  SvgGenImage get arrowRight =>
      const SvgGenImage('assets/icons/arrow_right.svg');
  SvgGenImage get calendar => const SvgGenImage('assets/icons/calendar.svg');
  SvgGenImage get calendarActive =>
      const SvgGenImage('assets/icons/calendar_active.svg');
  SvgGenImage get chevronLeft =>
      const SvgGenImage('assets/icons/chevron_left.svg');
  SvgGenImage get close => const SvgGenImage('assets/icons/close.svg');
  SvgGenImage get doctors => const SvgGenImage('assets/icons/doctors.svg');
  SvgGenImage get graphActive =>
      const SvgGenImage('assets/icons/graph_active.svg');
  SvgGenImage get graphInactive =>
      const SvgGenImage('assets/icons/graph_inactive.svg');
  SvgGenImage get measurementDefault =>
      const SvgGenImage('assets/icons/measurement_default.svg');
  SvgGenImage get measurementsActive =>
      const SvgGenImage('assets/icons/measurements_active.svg');
  SvgGenImage get measurementsInactive =>
      const SvgGenImage('assets/icons/measurements_inactive.svg');
  SvgGenImage get menuActive =>
      const SvgGenImage('assets/icons/menu_active.svg');
  SvgGenImage get menuAdd => const SvgGenImage('assets/icons/menu_add.svg');
  SvgGenImage get menuInactive =>
      const SvgGenImage('assets/icons/menu_inactive.svg');
  SvgGenImage get plus => const SvgGenImage('assets/icons/plus.svg');
  SvgGenImage get prescriptionsActive =>
      const SvgGenImage('assets/icons/prescriptions_active.svg');
  SvgGenImage get prescriptionsInactive =>
      const SvgGenImage('assets/icons/prescriptions_inactive.svg');
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');
  SvgGenImage get report => const SvgGenImage('assets/icons/report.svg');
  SvgGenImage get settings => const SvgGenImage('assets/icons/settings.svg');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get delete => const AssetGenImage('assets/images/delete.png');
  AssetGenImage get emptyAvatar =>
      const AssetGenImage('assets/images/empty_avatar.png');
  AssetGenImage get faceId => const AssetGenImage('assets/images/face_id.png');
  AssetGenImage get intro => const AssetGenImage('assets/images/intro.png');
  AssetGenImage get introSecure =>
      const AssetGenImage('assets/images/intro_secure.png');
  AssetGenImage get logoSymbol =>
      const AssetGenImage('assets/images/logo_symbol.png');
  AssetGenImage get profileImageDefault =>
      const AssetGenImage('assets/images/profile_image_default.png');
  AssetGenImage get touchId =>
      const AssetGenImage('assets/images/touch_id.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName)
      : _assetName = assetName,
        super(assetName);
  final String _assetName;

  Image image({
    Key key,
    ImageFrameBuilder frameBuilder,
    ImageLoadingBuilder loadingBuilder,
    ImageErrorWidgetBuilder errorBuilder,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key key,
    bool matchTextDirection = false,
    AssetBundle bundle,
    String package,
    double width,
    double height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder placeholderBuilder,
    Color color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
