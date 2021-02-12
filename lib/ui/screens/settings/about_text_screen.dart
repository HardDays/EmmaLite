import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutTextScreen extends StatefulWidget {
  final String title;
  final String filePath;

  const AboutTextScreen({Key key, this.title, this.filePath}) : super(key: key);

  @override
  _AboutTextScreenState createState() => _AboutTextScreenState();
}

class _AboutTextScreenState extends State<AboutTextScreen> {
  bool _loading = true;

  PDFDocument _document;

  @override
  void initState() {
    _load();
    super.initState();
  }

  Future<void> _load() async {
    _document = await PDFDocument.fromAsset(widget.filePath);
    await _document.preloadPages();
    if (mounted)
      setState(() {
        _loading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Column(
        children: [
          EmmaAppBar(
            title: widget.title,
            leading: BackLeading(
              text: 'differenceBackTextLabel'.tr.capitalizeFirst,
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (_loading) {
                  return Center(
                    child: Platform.isAndroid
                        ? const CircularProgressIndicator()
                        : const CupertinoActivityIndicator(),
                  );
                }
                return PDFViewer(
                  document: _document,
                  lazyLoad: false,
                  scrollDirection: Axis.vertical,
                  showPicker: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
