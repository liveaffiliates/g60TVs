
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:g60/locator.dart';
import 'base_viewmodel.dart';


class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;

  BaseView({required this.builder, required this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {

  T model = locator<T>();

  @override
  void initState() {
    widget.onModelReady(model);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(create: (context) => model, child: Consumer<T>(builder: widget.builder));
  }
}
