import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({
    Key? key,
    required this.globalKey,
    required this.title,
    required this.description,
    required this.shapeBorder,
    required this.child,
  }) : super(key: key);

  final GlobalKey globalKey;
  final String title;
  final String description;
  final ShapeBorder shapeBorder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      title: title,
      description: description,
      targetShapeBorder: shapeBorder,
      child: child,
    );
  }
}
