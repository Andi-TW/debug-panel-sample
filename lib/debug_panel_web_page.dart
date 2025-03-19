import 'dart:convert';

import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:debug_panel_sample/main.dart';
import 'package:flutter/material.dart';

class DebugPanelWebPage extends StatelessWidget {
  const DebugPanelWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Debug Panel Demo Page',
        ),
      ),
      body: DebugPanelDetailsView(
        response: BookingDebugPanelResponse.fromJson(jsonDecode(dataJson)),
        dictionaries: BookingDebugPanelDictionaries.fromJson(
            jsonDecode(dictionariesJson)),
        decoration: BookingDebugPanelRuleSetViewDecorationImpl(),
        label: BookingDebugPanelRuleSetViewLabel(
          statusLabel: 'APPLIED',
          rulesSetContentViewLabel: BookingDebugPanelRulesSetContentViewLabel(
            rulesOverviewText: 'Rules Overview',
            overviewWidgetLabel: BookingDebugPanelOverviewWidgetLabel(
              conditionViewLabel: BookingDebugPanelConditionViewLabel(
                actionLabel: 'ACTION',
                variableLabel: 'Variable',
                valueLabel: 'Value',
                replaceLabel: 'Replace',
                withLabel: 'With',
                contentsLabel: 'Contents',
                positionLabel: 'Position',
                propertyLabel: 'Property',
                componentsConfiguration: 'Components Configuration',
                noActionLabel: 'NO ACTION',
                noConditionLabel: 'IF NO',
                yesConditionLabel: 'IF YES',
                conditionLabel: 'CONDITION',
              ),
            ),
            executedRulesText: 'Executed Rules',
            outputActionsText: 'Output Actions',
            undefined: 'Undefined',
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DebugPanelDetailsView extends StatelessWidget {
  final BookingDebugPanelResponse response;
  final BookingDebugPanelDictionaries dictionaries;
  final BookingDebugPanelRuleSetViewLabel label;
  final BookingDebugPanelRuleSetViewDecoration decoration;

  const DebugPanelDetailsView({
    super.key,
    required this.response,
    required this.dictionaries,
    required this.label,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: dictionaries.rulesets?.entries.map(
                (e) {
                  return BookingDebugPanelRuleSetView(
                    initialExpanded: true,
                    rulesetId: e.key,
                    ruleSet: e.value,
                    label: label,
                    decoration: decoration,
                    operatorText: (operatorCode) =>
                        dictionaries.operators?[operatorCode ?? ''] ?? '',
                    ruleSetDetails: (rulesetId) =>
                        response.debug?.adminRules?.rulesets?.firstWhere(
                      (element) => element.rulesetId == rulesetId,
                    ),
                  );
                },
              ).toList() ??
              [],
        ),
      ),
    );
  }
}

class BookingDebugPanelRuleSetView extends StatefulWidget {
  final bool initialExpanded;
  final String rulesetId;
  final BookingDebugPanelRulesetsTemp ruleSet;
  final BookingDebugPanelRuleSetViewLabel label;
  final BookingDebugPanelRuleSetViewDecoration decoration;
  final String Function(String? operatorCode) operatorText;
  final BookingDebugPanelRuleSet? Function(String? rulesetId) ruleSetDetails;

  const BookingDebugPanelRuleSetView({
    super.key,
    required this.initialExpanded,
    required this.rulesetId,
    required this.ruleSet,
    required this.label,
    required this.decoration,
    required this.operatorText,
    required this.ruleSetDetails,
  });

  @override
  State<BookingDebugPanelRuleSetView> createState() => _BookingDebugPanelRuleSetViewState();
}

class _BookingDebugPanelRuleSetViewState
    extends State<BookingDebugPanelRuleSetView> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = widget.initialExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFFE1E7EA),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              setState(() => isExpanded = !isExpanded);
            },
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  widget.ruleSet.name ?? '',
                  style: widget.decoration.titleStyle,
                )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: widget.decoration.positiveStatusColor ?? Colors.grey,
                        width: 1.0,
                      )),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  child: Text(
                    widget.label.statusLabel,
                    style: widget.decoration.positiveStatusStyle,
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            BookingDebugPanelRulesSetContentView(
              ruleSet: widget.ruleSet,
              rulesetId: widget.rulesetId,
              label: widget.label.rulesSetContentViewLabel,
              decoration: BookingDebugPanelRulesSetContentViewDecorationImpl(),
              operatorText: widget.operatorText,
              ruleSetDetails: widget.ruleSetDetails,
            ),
        ],
      ),
    );
  }
}

class BookingDebugPanelRuleSetViewLabel {
  final String statusLabel;
  final BookingDebugPanelRulesSetContentViewLabel rulesSetContentViewLabel;

  BookingDebugPanelRuleSetViewLabel({
    required this.statusLabel,
    required this.rulesSetContentViewLabel,
  });
}

class BookingDebugPanelRuleSetViewDecoration {
  final TextStyle titleStyle;
  final TextStyle positiveStatusStyle;
  final Color? positiveStatusColor;

  BookingDebugPanelRuleSetViewDecoration({
    required this.titleStyle,
    required this.positiveStatusStyle,
    required this.positiveStatusColor,
  });
}

class BookingDebugPanelRuleSetViewDecorationImpl
    implements BookingDebugPanelRuleSetViewDecoration {
  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        color: Color(0xFF333333),
      );

  @override
  TextStyle get positiveStatusStyle => const TextStyle(
        color: Color(0xFF1DB36E),
        fontWeight: FontWeight.w700,
        fontSize: 10.0,
      );

  @override
  Color? get positiveStatusColor => const Color(0xFF1DB36E);
}