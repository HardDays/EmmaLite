import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class TextFieldBlock extends StatelessWidget {
  const TextFieldBlock({Key key, this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cFFFFFF, borderRadius: BorderRadius.circular(4)),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: children[index],
        ),
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Divider(color: AppColors.cE6E9EB, height: 2),
        ),
        itemCount: children.length,
      ),
    );
  }
}
