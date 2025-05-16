import 'package:flutter/material.dart';

import '../../../core/bases/base_inherited_widget.dart';
import '../../../core/bases/base_statless_widget.dart';

class SectionTitleTextItem extends BaseStatelessWidget {
  const SectionTitleTextItem({super.key, required this.title});

  final String title;

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: inherit.screenWidth * .04),
      child: Text(
        title,
        style: inherit.theme.textTheme.titleMedium!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
