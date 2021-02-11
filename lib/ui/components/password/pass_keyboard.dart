import 'dart:math';

import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class PassKey extends StatefulWidget {
  final Function(List<int> values) onChange;
  final Function onFaceIdTap;
  final bool haveFaceId;
  final BiometricType localAuthType;
  final List<int> keys;

  const PassKey({
    Key key,
    this.onChange,
    this.onFaceIdTap,
    this.haveFaceId = true,
    this.localAuthType,
    this.keys,
  }) : super(key: key);

  @override
  _PassKeyState createState() => _PassKeyState();
}

class _PassKeyState extends State<PassKey> {
  List<int> _values = [];

  void _onAddValue(int v) {
    if (_values.length == 4) {
      return;
    }
    _values.add(v);
    widget.onChange?.call(_values);
  }

  void _onDelete() {
    if (_values.isNotEmpty) {
      _values.removeLast();
      widget.onChange.call(_values);
    }
  }

  @override
  void didUpdateWidget(covariant PassKey oldWidget) {
    if (widget.keys != _values) {
      _values = widget.keys;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PassKeyItem(text: 1, onTap: _onAddValue),
                _PassKeyItem(text: 2, onTap: _onAddValue),
                _PassKeyItem(text: 3, onTap: _onAddValue),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 12.h)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PassKeyItem(text: 4, onTap: _onAddValue),
                _PassKeyItem(text: 5, onTap: _onAddValue),
                _PassKeyItem(text: 6, onTap: _onAddValue),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 12.h)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PassKeyItem(text: 7, onTap: _onAddValue),
                _PassKeyItem(text: 8, onTap: _onAddValue),
                _PassKeyItem(text: 9, onTap: _onAddValue),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 12.h)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.haveFaceId
                    ? _FaceIdButton(
                        localAuthType: widget.localAuthType,
                        onTap: widget.onFaceIdTap,
                      )
                    : SizedBox(width: 54.w),
                _PassKeyItem(text: 0, onTap: _onAddValue),
                _DeleteButton(onTap: _onDelete),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FaceIdButton extends StatelessWidget {
  final BiometricType localAuthType;
  final Function onTap;

  const _FaceIdButton({
    Key key,
    this.localAuthType,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 54.w,
        height: 54.w,
        child: Center(
          child: localAuthType == BiometricType.face
              ? AppIcons.faceId()
              : AppIcons.touchId(),
        ),
      ),
    );
  }
}

class _DeleteButton extends StatefulWidget {
  final Function onTap;

  const _DeleteButton({Key key, this.onTap}) : super(key: key);

  @override
  __DeleteButtonState createState() => __DeleteButtonState();
}

class __DeleteButtonState extends State<_DeleteButton> {
  bool _isActive = false;

  void _setActive(bool v) {
    _isActive = v;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (v) {
        _setActive(false);
        widget.onTap?.call();
      },
      onTapDown: (v) {
        _setActive(true);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 54.w,
        height: 54.w,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Center(
              child: Transform.scale(
                scale: 1.3,
                child: AppIcons.delete(
                  color: _isActive ? AppColors.c00ACE3 : AppColors.cF5F7FA,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: Transform.rotate(
                  angle: pi / 4,
                  child: AppIcons.plus(
                    size: 14.w,
                    color: _isActive ? AppColors.cFFFFFF : AppColors.c000000,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PassKeyItem extends StatefulWidget {
  final int text;
  final Function onTap;

  const _PassKeyItem({Key key, this.text, this.onTap}) : super(key: key);

  @override
  __PassKeyItemState createState() => __PassKeyItemState();
}

class __PassKeyItemState extends State<_PassKeyItem> {
  bool _isActive = false;

  void _setActive(bool v) {
    _isActive = v;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (v) {
        _setActive(false);
      },
      onTapDown: (v) {
        widget.onTap?.call(widget.text);
        _setActive(true);
      },
      child: Container(
        width: 54.w,
        height: 54.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isActive ? AppColors.c00ACE3 : AppColors.cF5F7FA,
        ),
        child: Center(
          child: Text(
            widget.text.toString(),
            style: AppTypography.font24.copyWith(
              color: _isActive ? AppColors.cFFFFFF : AppColors.c000000,
            ),
          ),
        ),
      ),
    );
  }
}
