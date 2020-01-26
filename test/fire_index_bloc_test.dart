// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamu_hack_2020/fire_index_bloc.dart';

import 'package:tamu_hack_2020/main.dart';

void main() {
  test("Test that bloc stream return a fire index when it is requested", (){
    final bloc = FireIndexBloc();
    bloc.requestFireIndex(-30.9546892, 121.164108);

    bloc.fireIndexStream.listen((fire_index) => expect(fire_index, isNotNull));
  });
}
