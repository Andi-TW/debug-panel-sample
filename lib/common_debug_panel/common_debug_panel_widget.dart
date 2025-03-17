import 'dart:convert';

import 'package:debug_panel_sample/common_debug_panel/debug_panel_modal_ctrl.dart';
import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:debug_panel_sample/helpers/bottom_sheets.dart';
import 'package:debug_panel_sample/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDebugPanelWidget extends StatefulWidget {
  final Widget child;
  final CommonDebugPanelWidgetDecoration decoration;
  final CommonDebugPanelWidgetLabel label;

  const CommonDebugPanelWidget({
    super.key,
    required this.child,
    required this.decoration,
    required this.label,
  });

  @override
  State<CommonDebugPanelWidget> createState() => _CommonDebugPanelWidgetState();
}

class _CommonDebugPanelWidgetState extends State<CommonDebugPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          widget.child,
          Positioned(
            bottom: 22.0,
            left: 18.0,
            child: DebugPanelButton(
              onPressed: () async {
                await _showContributionPicker();
              },
              label: widget.label.buttonLabel,
              decoration: widget.decoration.buttonDecoration,
            ),
          )
        ],
      ),
    );
  }

  _showContributionPicker() async {
    Get.bottomSheet(
      GetBuilder<DebugPanelModalCtrl>(
        init: DebugPanelModalCtrl(),
        builder: (controller) {
          return StyledBottomSheet(
            sheetPadding: controller.isExpanded.value ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
            backgroundColor: const Color(0xFFF0F3F5),
            isExpanded: false,
            maxHeight: controller.isExpanded.value ? null : controller.minHeight,
            content: BookingDebugPanelPage(
              response: DebugPanelResponse.fromJson(jsonDecode(dataJson)),
              decoration: BookingDebugPanelPageDecorationImpl(),
              label: BookingDebugPanelPageLabel(
                titleLabel: 'Debug Information',
                showLocalisationLabel: 'Show localisation key',
                hideHistoryLabel: 'Hide Ruleset History',
                executionHistoryLabel: 'Ruleset Execution History',
                searchLabel: 'Search',
              ),
              onTapRulesButton: () {
                controller.switchExpanded();
              },
              onTapCloseButton: () {
                Get.back();
              },
            ),
          );
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.blue,
      isScrollControlled: true,
    );
  }
}

class DebugPanelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final DebugPanelButtonDecoration decoration;

  const DebugPanelButton({
    super.key, 
    required this.onPressed,
    required this.label,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: decoration.backgroundColor,
        side: BorderSide(
          color: decoration.textColor ?? Colors.grey,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          decoration.image,
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: decoration.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DebugPanelButtonDecoration {
  final Color? backgroundColor;
  final Color? textColor;
  final Widget image;

  DebugPanelButtonDecoration({
    required this.backgroundColor, 
    required this.textColor,
    required this.image,
  });
}

class CommonDebugPanelWidgetDecoration {
  final DebugPanelButtonDecoration buttonDecoration;

  CommonDebugPanelWidgetDecoration({
    required this.buttonDecoration,
  });
}

class CommonDebugPanelWidgetLabel {
  final String buttonLabel;

  CommonDebugPanelWidgetLabel({
    required this.buttonLabel,
  });
}