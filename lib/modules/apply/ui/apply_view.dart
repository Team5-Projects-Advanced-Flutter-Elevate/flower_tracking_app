import 'package:flutter/material.dart';

import '../../../core/bases/base_inherited_widget.dart';
import '../../../core/bases/base_statless_widget.dart';

class ApplyView extends BaseStatelessWidget {
  const ApplyView({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text("Apply", style: inherit.theme.textTheme.titleLarge),
      ),
      body: Column(children: []),
    );
  }
}
