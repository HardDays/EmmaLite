import 'dart:io';

import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPhotoScreen extends StatefulWidget {
  final List<String> photos;
  final int initIndex;
  final Function(int index) onDelete;

  const DetailPhotoScreen({
    Key key,
    this.photos,
    this.initIndex,
    this.onDelete,
  }) : super(key: key);

  @override
  _DetailPhotoScreenState createState() => _DetailPhotoScreenState();
}

class _DetailPhotoScreenState extends State<DetailPhotoScreen> {
  PageController _controller;

  List<String> photos;

  int page;

  @override
  void initState() {
    page = widget.initIndex;
    photos = []..addAll(widget.photos);

    _controller = PageController(initialPage: widget.initIndex ?? 0)
      ..addListener(_listener);
    super.initState();
  }

  void _listener() {
    final currentPage = _controller.page.ceil();
    if (currentPage != page) {
      setState(() {
        page = currentPage;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final index = page + 1 > photos.length ? photos.length : page + 1;
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Column(
        children: [
          SmallAppBar(
            title: '$index из ${photos.length}',
            leadingText: 'Закрыть',
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: photos.length,
              itemBuilder: (_, i) {
                return InteractiveViewer(
                  child: Image.file(
                    File(photos[i]),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 64.h,
            color: AppColors.cFFFFFF,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  photos.removeAt(page);
                  widget?.onDelete(page);
                  if (photos.isEmpty) {
                    Navigator.of(context).pop();
                  } else {
                    setState(() {});
                  }

                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: AppIcons.trash(color: AppColors.cA0B4CB),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
