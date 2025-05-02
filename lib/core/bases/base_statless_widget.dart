import 'package:flutter/material.dart';

import 'base_inherited_widget.dart';

late BuildContext _context;
late ThemeData _theme;

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _context = context;
    BaseInheritedWidget inherit = BaseInheritedWidget.of(context);
    _theme = inherit.theme;

    return customBuild(context, inherit);
  }

  Widget customBuild(BuildContext context, BaseInheritedWidget inherit);

  Future<void> displayAlertDialog() async {}

  void hideAlertDialog() {
    Navigator.of(_context, rootNavigator: true).pop();
  }
}
