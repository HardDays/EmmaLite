import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:flutter/material.dart';

class EmmaAppBar extends AppBar {
  @override
  final Widget leading;
  final String titleText;
  @override
  final bool centerTitle;
  final Widget bottomWidget;

  EmmaAppBar({
    @required this.titleText,
    this.centerTitle = false,
    this.leading,
    this.bottomWidget,
  }) : super(
          centerTitle: centerTitle,
          title: Text(titleText, style: CustomTextStyles.expandedAppBarTitle),
          automaticallyImplyLeading: false,
          leading: leading,
          titleSpacing: 0,
          bottom: bottomWidget,
        );
}

// class EmmaAppBar extends StatelessWidget with PreferredSizeWidget {
//   const EmmaAppBar(
//       {this.leading,
//       @required this.titleText,
//       this.centerTitle = true,
//       this.height = 0,
//       this.bottomWidget});

//   final Widget leading;
//   final String titleText;
//   final bool centerTitle;
//   final Widget bottomWidget;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 4.0,
//       child: Container(
//         height: preferredSize.height,
//         color: CustomColors.white,
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const WSpace(16),
//             leading,
//             Text(titleText, style: CustomTextStyles.expandedAppBarTitle),

//           ],
//         )
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight+height);
// }
