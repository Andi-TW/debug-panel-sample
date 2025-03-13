import 'dart:convert';

import 'package:debug_panel_sample/debug_panel_modal_ctrl.dart';
import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/helpers/bottom_sheets.dart';
import 'package:debug_panel_sample/main.dart';
import 'package:debug_panel_sample/scrollable_debug_panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommonDebugPanelWidget extends StatefulWidget {
  final Widget child;

  const CommonDebugPanelWidget({
    super.key,
    required this.child,
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
            child: _DebugPanelButton(
              onPressed: () async {
                await _showContributionPicker();
              },
              image: SvgPicture.asset(
                'assets/bug.svg',
                fit: BoxFit.scaleDown,
              ),
              text: 'Debug Panel',
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
            content: MainPage(
              response: DebugPanelResponse.fromJson(jsonDecode(dataJson)),
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

class _DebugPanelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget image;
  final String text;

  const _DebugPanelButton({
    required this.onPressed,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF0F3F5),
        foregroundColor: Colors.black,
        side: const BorderSide(
          color: Color(0xFF1F4074),
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
          image,
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Color(0xFF1F4074),
            ),
          ),
        ],
      ),
    );
  }
}