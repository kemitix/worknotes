import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Finds the first matching widget and returns the text of the field from its
/// controller.
///
/// Will throw a cast error if the widget is not a `TextFormField`
///
/// Will throw a null error if the `TextFormField` doesn't have a controller
String textFromTextFormField(WidgetTester widgetTester, Finder finder) =>
    (widgetTester.firstWidget(finder) as TextFormField).controller!.text;
