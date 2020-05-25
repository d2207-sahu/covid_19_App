import 'package:covid19/ViewModel/BaseModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  /// Never EVer Make the sipodew method here gives error because provider provides deispose() in it
  /// by defauokt ///

  BaseView({
    this.builder,
    this.onModelReady,
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => locator<T>(),
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }
}
