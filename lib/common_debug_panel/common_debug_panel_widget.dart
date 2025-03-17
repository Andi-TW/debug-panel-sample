import 'dart:convert';

import 'package:debug_panel_sample/booking_debug_panel_view.dart';
import 'package:debug_panel_sample/common_debug_panel/debug_panel_modal_ctrl.dart';
import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:debug_panel_sample/helpers/bottom_sheets.dart';
import 'package:debug_panel_sample/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              response: BookingDebugPanelResponse.fromJson(jsonDecode(dataJson)),
              dictionaries: BookingDebugPanelDictionaries.fromJson(jsonDecode(dictionariesJson)),
              decoration: BookingDebugPanelPageDecorationImpl(),
              label: BookingDebugPanelPageLabel(
                titleLabel: 'Debug Information',
                showLocalisationLabel: 'Show localisation key',
                hideHistoryLabel: 'Hide Ruleset History',
                executionHistoryLabel: 'Ruleset Execution History',
                searchLabel: 'Search',
                positiveStatusLabel: 'APPLIED',
                appVersionLabel: 'App version',
                clientRefLabel: 'Ama-Client-Ref',
                startedDateLabel: 'Started at',
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

class BookingDebugPanelPageDecorationImpl
    implements BookingDebugPanelPageDecoration {
  @override
  Color? get backgroundColor => const Color(0xFFF0F3F5);

  @override
  DebugInformationDetailsViewDecoration
      get debugInformationDetailsViewDecoration =>
          DebugInformationDetailsViewDecorationImpl();

  @override
  CheckboxViewDecoration get checkboxViewDecoration =>
      CheckboxViewDecorationImpl();

  @override
  TextStyle get titleStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get executionHistoryLabelStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xFF0D4689),
      );

  @override
  TextStyle get searchHintStyle => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Color(0xFF333333),
      );

  @override
  Widget get searchIcon => SvgPicture.asset(
        'assets/search.svg',
        fit: BoxFit.scaleDown,
      );

  @override
  DebugPanelExpandablePanelDecorationImpl get expandablePanelDecoration =>
      DebugPanelExpandablePanelDecorationImpl();

  @override
  Color? get thumbColor => const Color(0xFF0D4689);

  @override
  Widget get titleIcon => SvgPicture.asset(
        'assets/bug.svg',
        width: 16.0,
        height: 22.0,
      );

  @override
  Widget get closeIcon => const Icon(
        Icons.close,
        color: Color(0xFF0D4689),
      );
}

class CheckboxViewDecorationImpl implements CheckboxViewDecoration {
  @override
  Color? get activeColor => const Color(0xFF0D4689);

  @override
  Color? get borderColor => const Color(0xFFA7B6BF);

  @override
  Color? get checkColor => Colors.white;

  @override
  TextStyle get labelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF0D4689),
      );
}

class DebugPanelExpandablePanelDecorationImpl
    implements DebugPanelExpandablePanelDecoration {
  @override
  Color? get positiveStatusColor => const Color(0xFF1DB36E);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        color: Color(0xFF333333),
      );
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