import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:flutter/material.dart';

class DebugPanelView extends StatelessWidget {
  final DebugPanelResponse response;

  const DebugPanelView({
    super.key,
    required this.response,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, RulesetsTemp>? rulesets =
        response.debug?.adminRules?.dictionaries?.rulesets;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rulesets?.entries.map(
                (e) {
                  return RuleSetView(
                    initialExpanded: true,
                    rulesetId: e.key,
                    ruleSet: e.value,
                    operatorText: (operatorCode) =>
                        response.debug?.adminRules?.dictionaries
                            ?.operators?[operatorCode ?? ''] ??
                        '',
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

class RuleSetView extends StatefulWidget {
  final bool initialExpanded;
  final String rulesetId;
  final RulesetsTemp ruleSet;
  final String Function(String? operatorCode) operatorText;
  final RuleSet? Function(String? rulesetId) ruleSetDetails;

  const RuleSetView({
    super.key,
    required this.initialExpanded,
    required this.rulesetId,
    required this.ruleSet,
    required this.operatorText,
    required this.ruleSetDetails,
  });

  @override
  State<RuleSetView> createState() => _RuleSetViewState();
}

class _RuleSetViewState extends State<RuleSetView> {
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
          )),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        color: Color(0xFF333333)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: const Color(0xFF1DB36E),
                        width: 1.0,
                      )),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  child: const Text(
                    'APPLIED',
                    style: TextStyle(
                      color: Color(0xFF1DB36E),
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            RulesSetContentView(
              ruleSet: widget.ruleSet, 
              rulesetId: widget.rulesetId, 
              operatorText: widget.operatorText, 
              ruleSetDetails: widget.ruleSetDetails,
            ),
        ],
      ),
    );
  }
}

class RulesSetContentView extends StatelessWidget {
  final RulesetsTemp ruleSet;
  final String rulesetId;
  final String Function(String? operatorCode) operatorText;
  final RuleSet? Function(String? rulesetId) ruleSetDetails;

  const RulesSetContentView({
    super.key,
    required this.ruleSet,
    required this.rulesetId,
    required this.operatorText,
    required this.ruleSetDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                DebugPanelSection(
                  titleBackgroundColor: const Color(0xFFE1E7EA),
                  title: 'Rules Overview',
                  child: Column(
                    children: ruleSet.rules?.entries
                            .map(
                              (rule) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: OverviewWidget(
                                  rules: rule.value,
                                  operatorText: operatorText,
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
                DebugPanelSection(
                  titleBackgroundColor: const Color(0xFFE1E7EA),
                  title: 'Input snapshot',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _propertyLabel(
                        tag: 'flowType',
                        tagStyle: _blueLabelTextStyle,
                        value: 'booking',
                        valueStyle: _greenLabelTextStyle,
                      ),
                      _propertyLabel(
                        tag: 'portalFacts',
                        tagStyle: _blueLabelTextStyle,
                        value: '{ "officeId": "KULMH08FX" }',
                        valueStyle: _greenLabelTextStyle,
                      ),
                      _propertyLabel(
                        tag: 'language',
                        tagStyle: _blueLabelTextStyle,
                        value: 'en-GB',
                        valueStyle: _greenLabelTextStyle,
                      ),
                    ],
                  ),
                ),
                DebugPanelSection(
                  titleBackgroundColor: const Color(0xFFE1E7EA),
                  title: 'Output Actions',
                  child: Column(
                    children: [
                      _verticalPropertyLabel(
                        tag:
                            'Update placeholder in TravelerComponent @refx/booking',
                        tagStyle: _blackLabelTextStyle,
                        value:
                            'ph-refx-traveler-management-cont-top → rules/contents/traveller/travellers-name-guide-text/master.json',
                        valueStyle: _greenLabelTextStyle,
                      ),
                    ],
                  ),
                ),
                DebugPanelSection(
                  titleBackgroundColor: const Color(0xFFE1E7EA),
                  title: 'Output Actions',
                  child: Column(
                    children: [
                      _propertyWithCaptionLabel(
                        caption:
                            'Update Config TravelerManagementContConfig @refx/booking',
                        captionStyle: _blackLabelTextStyle,
                        tag: 'programs',
                        tagStyle: _blueLabelTextStyle,
                        value:
                            '[ "MH", "AS", "AA", "BA", "CX", "EK", "EY", "AY", "IB", "JL", "KL", "SQ", "QF" ]',
                        valueStyle: _greenLabelTextStyle,
                      ),
                      _propertyWithCaptionLabel(
                        caption:
                            'Update Config TravelerManagementContConfig @refx/booking-components',
                        captionStyle: _blackLabelTextStyle,
                        tag: 'programs',
                        tagStyle: _blueLabelTextStyle,
                        value:
                            '[\n"MH",\n"AS",\n"AA",\n"BA",\n"CX",\n"EK",\n"EY",\n"AY",\n"IB",\n"JL",\n"KL",\n"SQ",\n"QF",\n"QR",\n"AT",\n"RJ",\n"S7",\n"UL"\n]',
                        valueStyle: _greenLabelTextStyle,
                      ),
                    ],
                  ),
                ),
                DebugPanelSection(
                  titleBackgroundColor: const Color(0xFFE1E7EA),
                  title: 'Output Actions',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ruleSet.rules?.entries.map(
                          (rules) {
                            Rule? newRules = ruleSetDetails
                                .call(rulesetId)
                                ?.executedRules
                                ?.firstWhere(
                                  (e) => e.ruleId == rules.key,
                                );
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: ExecutedRulesView(
                                title: rules.value.name ?? '',
                                rule: newRules,
                              ),
                            );
                          },
                        ).toList() ??
                        [],
                  ),
                ),
              ],
            );
  }

  TextStyle get _blueLabelTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF0066B3),
      );

  TextStyle get _greenLabelTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1DB36E),
      );

  TextStyle get _blackLabelTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  Widget _propertyLabel({
    required String tag,
    required TextStyle tagStyle,
    required String value,
    required TextStyle valueStyle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: tagStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Flexible(
          child: RichText(
            text: TextSpan(text: '$tag: ', style: tagStyle, children: [
              TextSpan(
                text: value,
                style: valueStyle,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _verticalPropertyLabel({
    required String tag,
    required TextStyle tagStyle,
    required String value,
    required TextStyle valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: tagStyle,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tag,
                  style: tagStyle,
                ),
                Text(
                  value,
                  style: valueStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _propertyWithCaptionLabel({
    required String caption,
    required TextStyle captionStyle,
    required String tag,
    required TextStyle tagStyle,
    required String value,
    required TextStyle valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '•',
            style: captionStyle,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caption,
                  style: captionStyle,
                ),
                Row(
                  children: [
                    Text(
                      tag,
                      style: tagStyle,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '=',
                      style: captionStyle,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      value,
                      style: valueStyle,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DebugPanelSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Color? titleBackgroundColor;

  const DebugPanelSection({
    super.key,
    required this.title,
    required this.child,
    this.titleBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              color: titleBackgroundColor,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class PillContentView extends StatelessWidget {
  final String title;
  final Color color;
  final Widget content;

  const PillContentView({
    super.key,
    required this.title,
    required this.color,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
              ),
              color: color,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            height: double.infinity,
            width: 4.0,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Color(0xFFCED8DD)),
                  bottom: BorderSide(width: 1, color: Color(0xFFCED8DD)),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 9.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  content,
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(3),
                bottomRight: Radius.circular(3),
              ),
              color: color,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            height: double.infinity,
            width: 4.0,
          ),
        ],
      ),
    );
  }
}

class OverviewWidget extends StatelessWidget {
  final RulesTemp rules;
  final String Function(String? operatorCode) operatorText;

  const OverviewWidget({
    super.key,
    required this.rules,
    required this.operatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '• ${rules.name ?? ''}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        ...rules.overview
                ?.map(
                  (e) => _generateOverviewViews(e),
                )
                .toList() ??
            [],
      ],
    );
  }

  Widget _generateOverviewViews(RuleElement overview) {
    if (overview.type == 'condition') {
      return ConditionView(
        conditions: overview.conditions ?? [],
        success: overview.success,
        failed: overview.failed,
        operatorText: operatorText,
      );
    } else if (overview.type == 'action') {
      return Column(
        children: overview.items
                ?.map(
                  (action) => _generateActionView(action),
                )
                .toList() ??
            [],
      );
    } else if (overview.actionType != null) {
      return _generateActionView(
        RulesAction(
          actionType: overview.actionType,
          components: overview.components,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _generateActionView(RulesAction action) {
    Widget propertyLabel(String tag, String value) {
      return Row(
        children: [
          Text(
            '$tag:',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10,
              color: Color(0xFFA7B6BF),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10,
              color: Color(0xFF333333),
            ),
          ),
        ],
      );
    }

    List<Widget> children = [];
    action.components?.forEach(
      (component) {
        children.add(
          propertyLabel(
            'Component Configuration',
            component.component ?? '',
          ),
        );
        component.properties?.forEach(
          (property) {
            children.add(Row(
              children: [
                propertyLabel(
                  'Property',
                  property.property ?? '',
                ),
                const SizedBox(width: 8.0),
                propertyLabel(
                  'Value',
                  property.value ?? '',
                ),
              ],
            ));
          },
        );
      },
    );

    action.placeholders?.forEach(
      (placeholder) {
        children.add(Row(
          children: [
            propertyLabel(
              'Position',
              placeholder.position ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              'Contents',
              placeholder.contents ?? '',
            ),
          ],
        ));
      },
    );

    action.replacements?.forEach(
      (replacement) {
        children.add(Row(
          children: [
            propertyLabel(
              'Replace',
              replacement.replace ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              'With',
              replacement.replaceWith ?? '',
            ),
          ],
        ));
      },
    );

    action.variables?.forEach(
      (variable) {
        children.add(Row(
          children: [
            propertyLabel(
              'Variable',
              variable.variable ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              'Value',
              variable.value ?? '',
            ),
          ],
        ));
      },
    );

    return ActionView(
      title: action.actionType ?? '',
      children: children,
    );
  }
}

class ConditionView extends StatelessWidget {
  final List<Condition> conditions;
  final List<RuleElement>? success;
  final List<RuleElement>? failed;
  final String Function(String? operatorCode) operatorText;

  const ConditionView({
    super.key,
    required this.conditions,
    this.success,
    this.failed,
    required this.operatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          PillContentView(
            title: 'CONDITION',
            color: const Color(0xFFE6A935),
            content: Column(
              children: _generateConditionViews(
                conditions: conditions,
                depth: 0,
                baseColor: Colors.white,
              ),
            ),
          ),
          success != null || failed != null
              ? ConditionResultView(
                  title: 'IF YES',
                  bgColor: const Color(0xFFEAF8F8),
                  textColor: const Color(0xFF00AFAD),
                  initialExpanded: true,
                  children: success
                          ?.map(
                            (e) => _generateElementViews(e),
                          )
                          .toList() ??
                      [const EmptyActionView()],
                )
              : const SizedBox(),
          success != null || failed != null
              ? ConditionResultView(
                  title: 'IF NO',
                  bgColor: const Color(0xFFFCEDF0),
                  textColor: const Color(0xFFD1223E),
                  initialExpanded: false,
                  children: failed
                          ?.map(
                            (e) => _generateElementViews(e),
                          )
                          .toList() ??
                      [const EmptyActionView()],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _generateElementViews(RuleElement element) {
    if (element.type == 'condition') {
      return ConditionView(
        conditions: element.conditions ?? [],
        success: element.success,
        failed: element.failed,
        operatorText: operatorText,
      );
    } else if (element.type == 'action') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: element.actions
                ?.map(
                  (action) => _generateActionView(action),
                )
                .toList() ??
            [],
      );
    }
    return const SizedBox();
  }

  Widget _generateActionView(RulesAction action) {
    Widget propertyLabel(String tag, String value) {
      return RichText(
        text: TextSpan(
          text: '$tag: ',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: Color(0xFFA7B6BF),
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 10,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> children = [];
    action.components?.forEach(
      (component) {
        children.add(
          propertyLabel(
            'Component Configuration',
            component.component ?? '',
          ),
        );
        component.properties?.forEach(
          (property) {
            children.add(
              Row(
                children: [
                  propertyLabel(
                    'Property',
                    property.property ?? '',
                  ),
                  const SizedBox(width: 8.0),
                  propertyLabel(
                    'Value',
                    property.value ?? '',
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    action.placeholders?.forEach(
      (placeholder) {
        children.add(Row(
          children: [
            propertyLabel(
              'Position',
              placeholder.position ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              'Contents',
              placeholder.contents ?? '',
            ),
          ],
        ));
      },
    );

    action.replacements?.forEach(
      (replacement) {
        children.add(Row(
          children: [
            propertyLabel(
              'Replace',
              replacement.replace ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              'With',
              replacement.replaceWith ?? '',
            ),
          ],
        ));
      },
    );

    action.variables?.forEach(
      (variable) {
        children.add(Row(
          children: [
            propertyLabel(
              'Variable',
              variable.variable ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              'Value',
              variable.value ?? '',
            ),
          ],
        ));
      },
    );

    return ActionView(
      title: action.actionType ?? '',
      children: children,
    );
  }

  List<Widget> _generateConditionViews(
      {required List<Condition> conditions,
      required int depth,
      required Color? baseColor}) {
    List<Widget> widgets = [];
    for (int i = 0; i < conditions.length; i++) {
      var condition = conditions[i];
      if (condition.conditionType == 'single') {
        widgets.add(
          _generateSingleConditionView(
            condition: condition,
          ),
        );
        if (i < (conditions.length - 1) && conditions[i + 1].conditionType == 'single') {
          widgets.add(
             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
          );
        }
      } else if (condition.conditionType == 'group') {
        widgets.add(
          _generateGroupConditionView(
            conditionOperator: condition.conditionOperator ?? '',
            conditions: _generateConditionViews(
              conditions: condition.conditions ?? [],
              depth: depth + 1,
              baseColor: baseColor,
            ),
            bgColor: depth % 2 == 1 ? baseColor : const Color(0xFFF0F3F5),
          ),
        );
      }
    }
    return widgets;
  }

  Widget _generateGroupConditionView({
    required String conditionOperator,
    required List<Widget> conditions,
    required Color? bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        right: 8.0,
      ),
      child: ConditionCompareView(
        comparisonText: conditionOperator,
        child: Container(
          color: bgColor,
          child: Column(
            children: [
              const SizedBox(height: 4.0,),
              ...conditions,
              const SizedBox(height: 4.0,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateSingleConditionView({
    required Condition condition,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ConditionCompareView(
        comparisonText: condition.conditionOperator ?? '',
        child: Column(
          children: [
            const SizedBox(height: 4.0,),
            ConditionCompareDetailsView(
              operand: condition.operand,
              operatorText: operatorText,
            ),
            const SizedBox(height: 4.0,),
          ],
        ),
      ),
    );
  }
}

class ConditionCompareView extends StatelessWidget {
  final String? comparisonText;
  final Widget child;

  const ConditionCompareView({
    super.key,
    required this.comparisonText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          comparisonText != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    bottom: 4.0,
                    left: 8.0,
                  ),
                  child: SizedBox(
                    width: 30,
                    child: Text(
                      comparisonText!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        color: Color(0xFFE6A935),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox(),
          Expanded(child: child),
        ],
      );
}

class ConditionCompareDetailsView extends StatelessWidget {
  final Operand? operand;
  final String Function(String? operatorCode) operatorText;

  const ConditionCompareDetailsView({
    super.key,
    required this.operand,
    required this.operatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Row(
            children: [
              TagLabel(
                text: operand?.lhs?.tag ?? '',
                bgColor: const Color(0xFFA7B6BF),
              ),
              Text(
                operand?.lhs?.value ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            operatorText.call(operand?.operator),
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Color(0xFFD1223E)),
          ),
        ),
        Flexible(
          flex: 2,
          child: Row(
            children: [
              TagLabel(
                text: operand?.rhs?.tag ?? '',
                bgColor: const Color(0xFF1DB36E),
              ),
              Expanded(
                child: Text(
                  operand?.rhs?.value ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      color: Color(0xFF333333)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TagLabel extends StatelessWidget {
  final String text;
  final Color? bgColor;

  const TagLabel({
    super.key,
    required this.text,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ActionView extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ActionView({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: PillContentView(
        title: 'ACTION: $title',
        color: const Color(0xFF0066B3),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class ConditionResultView extends StatefulWidget {
  final String title;
  final Color? bgColor;
  final Color? textColor;
  final List<Widget> children;
  final bool initialExpanded;

  const ConditionResultView({
    super.key,
    required this.title,
    this.bgColor,
    this.textColor,
    required this.children,
    required this.initialExpanded,
  });

  @override
  State<ConditionResultView> createState() => _ConditionResultViewState();
}

class _ConditionResultViewState extends State<ConditionResultView> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initialExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      width: 1.0,
      color: widget.textColor ?? Colors.grey,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
          color: widget.bgColor,
          border: Border(
            left: borderSide,
            right: borderSide,
            bottom: borderSide,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            child: Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: widget.textColor,
                    borderRadius: BorderRadius.circular(2.0), // Corner radius
                  ),
                  child: Center(
                    child: Text(
                      isExpanded ? '-' : '+',
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 8.0, // Text size
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10.0,
                    color: widget.textColor,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() => isExpanded = !isExpanded);
            },
          ),
          if (isExpanded) ...widget.children
        ],
      ),
    );
  }
}

class ExecutedRulesView extends StatelessWidget {
  final String title;
  final Rule? rule;

  const ExecutedRulesView({
    super.key,
    required this.title,
    required this.rule,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.0,
            color: Color(0xFF1F4074),
          ),
        ),
        DebugPanelSection(
          titleBackgroundColor: const Color(0xFFFCF5E6),
          title: 'Executed Rules',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: rule?.variables?.map(
                  (variable) {
                    return _propertyLabel(
                      tag: variable.property ?? '',
                      value: variable.value?.current ?? '',
                    );
                  },
                ).toList() ??
                [],
          ),
        ),
        DebugPanelSection(
          titleBackgroundColor: const Color(0xFFFCF5E6),
          title: 'Output Actions',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _generatePropertiesText(rule),
          ),
        ),
      ],
    );
  }

  TextStyle get _blueLabelTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF0066B3),
      );

  TextStyle get _greenLabelTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1DB36E),
      );

  TextStyle get _blackLabelTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  Widget _generateCaptionWithTextView({
    required String caption,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '•',
            style: _blackLabelTextStyle,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caption,
                  style: _blackLabelTextStyle,
                ),
                child,
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _generateEqualPropertyText({
    required String tag,
    required String value,
  }) {
    return Row(
      children: [
        Text(
          '• $tag',
          style: _blueLabelTextStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          '=',
          style: _blackLabelTextStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          value,
          style: _greenLabelTextStyle,
        ),
      ],
    );
  }

  Widget _generateReplacedPropertyText({
    required String from,
    required String to,
  }) {
    return Row(
      children: [
        Text(
          '• $from',
          style: _greenLabelTextStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          '→',
          style: _blackLabelTextStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          to,
          style: _greenLabelTextStyle,
        ),
      ],
    );
  }

  Widget _propertyLabel({
    required String tag,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: _blueLabelTextStyle,
        ),
        const SizedBox(width: 4.0),
        Text(
          '$tag:',
          style: _blueLabelTextStyle,
        ),
        const SizedBox(width: 4.0),
        Text(
          'undefined',
          style: _greenLabelTextStyle,
        ),
        Text(
          '→',
          style: _blackLabelTextStyle,
        ),
        Text(
          value,
          style: _greenLabelTextStyle,
        ),
      ],
    );
  }

  List<Widget> _generatePropertiesText(Rule? rules) {
    if (rules == null) return [];
    List<Widget> widgets = [];
    rules.actions?.forEach(
      (action) {
        action.components?.forEach(
          (component) {
            component.properties?.forEach(
              (property) {
                widgets.add(
                  _generateCaptionWithTextView(
                    caption:
                        '${action.actionType ?? ''} ${component.component ?? ''}',
                    child: _generateEqualPropertyText(
                      tag: property.property ?? '',
                      value: property.value ?? '',
                    ),
                  ),
                );
              },
            );
          },
        );

        action.placeholders?.forEach(
          (placeholder) {
            widgets.add(_generateCaptionWithTextView(
                caption: action.actionType ?? '',
                child: _generateReplacedPropertyText(
                  from: placeholder.position ?? '',
                  to: placeholder.contents ?? '',
                )));
          },
        );

        action.replacements?.forEach(
          (replacement) {
            widgets.add(_generateCaptionWithTextView(
              caption: action.actionType ?? '',
              child: _generateReplacedPropertyText(
                from: replacement.replace ?? '',
                to: replacement.replaceWith ?? '',
              ),
            ));
          },
        );

        action.variables?.forEach(
          (variable) {
            widgets.add(_generateCaptionWithTextView(
              caption: action.actionType ?? '',
              child: _generateEqualPropertyText(
                tag: variable.variable ?? '',
                value: variable.value ?? '',
              ),
            ));
          },
        );
      },
    );
    return widgets;
  }
}

class EmptyActionView extends StatelessWidget {
  const EmptyActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        alignment: Alignment.centerLeft,
        height: 33.0,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFCED8DD),
              width: 1.0,
            ),
            color: const Color(0xFFFAFBFC)),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: const Text(
          'NO ACTION',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            color: Color(0xFFCED8DD),
          ),
        ),
      ),
    );
  }
}
