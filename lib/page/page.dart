import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pemilihan_app/bloc/bloc.dart';
import 'package:pemilihan_app/share/share.dart';
import 'package:pemilihan_app/locator.dart';
import 'package:pemilihan_app/model/model.dart';

import 'component/component.dart';

part 'page_typeselection.dart';
part 'page_loginadmin.dart';
part 'page_loginpemantau.dart';
part 'page_dataviewer.dart';
part 'page_pemilihantempat.dart';
part 'page_inputdata.dart';

SnackBar snackBar({
  String contentText, String labelText, VoidCallback onPressed
}) => SnackBar(
  content: Text(contentText),
  action: SnackBarAction(
    label: labelText,
    onPressed: onPressed,
  ),
);

abstract class Page<T extends Bloc> extends StatefulWidget {

  final T _bloc = locator<T>();
  T get blc => _bloc;
  
  Page({
    Key key,
  }) : super(key: key);

  @override
  _PageState<T> createState() => _PageState<T>();

  @protected
  void init();

  @protected
  void dispose();

  @protected
  Widget build(BuildContext context);
}

class _PageState<T extends Bloc> extends State<Page<T>> {
  
  @override
  void initState() {
    if (widget.init != null) {
      widget.init();
      widget.blc.init();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.dispose != null) {
      widget.dispose();
      widget.blc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}