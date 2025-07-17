import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flower_tracking_app/modules/order_details/view_model/order_details_state.dart';
import 'package:flutter/material.dart';

class StatusButton extends StatefulWidget {
  final VoidCallback? onPress;
  final String buttonTitle;
  final Status containerStatus;

  const StatusButton({
    super.key,
    required this.containerStatus,
    required this.onPress,
    required this.buttonTitle,
  });

  @override
  State<StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends BaseStatefulWidgetState<StatusButton> {
  bool animate = true;
  Status innerStatus = Status.idle;
  @override
  void didUpdateWidget(covariant StatusButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.containerStatus == Status.success ||
        oldWidget.containerStatus == Status.error) &&
        widget.containerStatus == Status.idle) {
      innerStatus = widget.containerStatus;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        onEnd: () {
          setState(() {
            innerStatus = widget.containerStatus;
          });
        },
        padding: const EdgeInsets.all(8),
        width: widget.containerStatus == Status.idle ? screenWidth : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: switch (widget.containerStatus) {
            Status.idle => Colors.transparent,
            Status.loading => AppColors.mainColor,
            Status.success => AppColors.green,
            Status.error => AppColors.red,
          },
        ),
        child:
            innerStatus == Status.idle
                ? FilledButton(
                  style: FilledButton.styleFrom(),
                  onPressed: widget.onPress,
                  child: Text(
                    widget.buttonTitle,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                )
                : innerStatus == Status.loading
                ? Center(child: CircularProgressIndicator(color: AppColors.white))
                : innerStatus == Status.success
                ? const Icon(Icons.check, color: Colors.white,size: 35,)
                : innerStatus == Status.error
                ? const Icon(Icons.cancel_outlined, color: Colors.white,size: 35,)
                : const SizedBox(),
      ),
    );
  }
}
