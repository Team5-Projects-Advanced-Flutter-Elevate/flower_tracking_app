import 'package:auto_size_text/auto_size_text.dart';
import 'package:flower_tracking_app/core/bases/base_statless_widget.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarkerChildWidget extends BaseStatelessWidget {
  final String iconPath;
  final String text;

  const MarkerChildWidget({
    super.key,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: constraints.maxHeight / 2.7,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: inherit.screenWidth * 0.02,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(iconPath),
                    ),
                    SizedBox(width: inherit.screenWidth * 0.01),
                    Flexible(
                      fit: FlexFit.loose,
                      child: AutoSizeText(
                        text,
                        maxFontSize: 18,
                        minFontSize: 8,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: inherit.theme.textTheme.labelMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.imFellEnglish().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: CustomPaint(
                size: Size(
                  10,
                  (constraints.maxHeight / 2) - (constraints.maxHeight / 2.5),
                ),
                painter: TrianglePainter(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.mainColor
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(0, 0) // Top center
          ..lineTo(size.width, 0) // Bottom left
          ..lineTo(size.width / 2, size.height) // Bottom right
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
