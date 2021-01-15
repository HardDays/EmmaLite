import 'package:flutter/material.dart';

Future<T> navigatorPush<T extends Object>(BuildContext context, Widget screen,
        {bool root = false}) =>
    Navigator.of(context, rootNavigator: root).push<T>(MaterialPageRoute(
        settings: RouteSettings(name: screen.runtimeType.toString()),
        builder: (context) => screen));
Future<T> navigatorReplace<T extends Object, S>(
        BuildContext context, Widget screen, {bool root = false}) =>
    Navigator.of(context, rootNavigator: root).pushReplacement<T, S>(
        MaterialPageRoute(
            settings: RouteSettings(name: screen.runtimeType.toString()),
            builder: (context) => screen));

Future navigatorPop(BuildContext context, [result]) =>
    Navigator.of(context).maybePop(result);

Future<T> navigatorPushNamed<T extends Object>(
        BuildContext context, String routeName,
        {bool root = false}) =>
    Navigator.of(context, rootNavigator: root).pushNamed(routeName);
