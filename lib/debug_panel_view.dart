import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:flutter/material.dart';

class BookingDebugPanelRulesSetContentView extends StatelessWidget {
  final String rulesetId;
  final BookingDebugPanelRulesetsTemp ruleSet;
  final BookingDebugPanelRulesSetContentViewLabel label;
  final BookingDebugPanelRulesSetContentViewDecoration decoration;
  final String Function(String? operatorCode) operatorText;
  final BookingDebugPanelRuleSet? Function(String? rulesetId) ruleSetDetails;

  const BookingDebugPanelRulesSetContentView({
    super.key,
    required this.rulesetId,
    required this.ruleSet,
    required this.label,
    required this.decoration,
    required this.operatorText,
    required this.ruleSetDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookingDebugPanelSection(
          title: label.rulesOverviewText,
          decoration: decoration.sectionDecoration,
          child: Column(
            children: ruleSet.rules?.entries
                    .map(
                      (rule) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: BookingDebugPanelOverviewWidget(
                          rules: rule.value,
                          decoration: decoration.overviewWidgetDecoration,
                          label: label.overviewWidgetLabel,
                          operatorText: operatorText,
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        BookingDebugPanelSection(
          decoration: decoration.sectionDecoration,
          title: 'Input snapshot',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _propertyLabel(
                tag: 'flowType',
                tagStyle: decoration.tagLabelStyle,
                value: 'booking',
                valueStyle: decoration.valueLabelStyle,
              ),
              _propertyLabel(
                tag: 'portalFacts',
                tagStyle: decoration.tagLabelStyle,
                value: '{ "officeId": "KULMH08FX" }',
                valueStyle: decoration.valueLabelStyle,
              ),
              _propertyLabel(
                tag: 'language',
                tagStyle: decoration.tagLabelStyle,
                value: 'en-GB',
                valueStyle: decoration.valueLabelStyle,
              ),
            ],
          ),
        ),
        BookingDebugPanelSection(
          title: label.outputActionsText,
          decoration: decoration.sectionDecoration,
          child: Column(
            children: [
              _verticalPropertyLabel(
                tag: 'Update placeholder in TravelerComponent @refx/booking',
                tagStyle: decoration.captionLabelStyle,
                value:
                    'ph-refx-traveler-management-cont-top → rules/contents/traveller/travellers-name-guide-text/master.json',
                valueStyle: decoration.valueLabelStyle,
              ),
            ],
          ),
        ),
        BookingDebugPanelSection(
          title: label.outputActionsText,
          decoration: decoration.sectionDecoration,
          child: Column(
            children: [
              _propertyWithCaptionLabel(
                caption:
                    'Update Config TravelerManagementContConfig @refx/booking',
                captionStyle: decoration.captionLabelStyle,
                tag: 'programs',
                tagStyle: decoration.tagLabelStyle,
                value:
                    '[ "MH", "AS", "AA", "BA", "CX", "EK", "EY", "AY", "IB", "JL", "KL", "SQ", "QF" ]',
                valueStyle: decoration.valueLabelStyle,
              ),
              _propertyWithCaptionLabel(
                caption:
                    'Update Config TravelerManagementContConfig @refx/booking-components',
                captionStyle: decoration.captionLabelStyle,
                tag: 'programs',
                tagStyle: decoration.tagLabelStyle,
                value:
                    '[\n"MH",\n"AS",\n"AA",\n"BA",\n"CX",\n"EK",\n"EY",\n"AY",\n"IB",\n"JL",\n"KL",\n"SQ",\n"QF",\n"QR",\n"AT",\n"RJ",\n"S7",\n"UL"\n]',
                valueStyle: decoration.valueLabelStyle,
              ),
            ],
          ),
        ),
        BookingDebugPanelSection(
          title: label.outputActionsText,
          decoration: decoration.sectionDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ruleSet.rules?.entries.map(
                  (rules) {
                    BookingDebugPanelRule? newRules = ruleSetDetails
                        .call(rulesetId)
                        ?.executedRules
                        ?.firstWhere(
                          (e) => e.ruleId == rules.key,
                        );
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: BookingDebugPanelExecutedRulesView(
                        rule: newRules,
                        label: BookingDebugPanelExecutedRulesViewLabel(
                          title: rules.value.name ?? '',
                          executedRulesText: label.executedRulesText,
                          outputActionsText: label.outputActionsText,
                          undefined: label.undefined,
                        ),
                        decoration: decoration.executedRulesViewDecoration,
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

class BookingDebugPanelRulesSetContentViewLabel {
  final String rulesOverviewText;
  final BookingDebugPanelOverviewWidgetLabel overviewWidgetLabel;
  final String executedRulesText;
  final String outputActionsText;
  final String undefined;

  BookingDebugPanelRulesSetContentViewLabel({
    required this.rulesOverviewText,
    required this.overviewWidgetLabel,
    required this.executedRulesText,
    required this.outputActionsText,
    required this.undefined,
  });
}

class BookingDebugPanelRulesSetContentViewDecoration {
  final TextStyle captionLabelStyle;
  final TextStyle tagLabelStyle;
  final TextStyle valueLabelStyle;
  final BookingDebugPanelOverviewWidgetDecoration overviewWidgetDecoration;
  final BookingDebugPanelSectionDecoration sectionDecoration;
  final BookingDebugPanelExecutedRulesViewDecoration executedRulesViewDecoration;

  BookingDebugPanelRulesSetContentViewDecoration({
    required this.captionLabelStyle,
    required this.tagLabelStyle,
    required this.valueLabelStyle,
    required this.overviewWidgetDecoration,
    required this.sectionDecoration,
    required this.executedRulesViewDecoration,
  });
}

class BookingDebugPanelSection extends StatelessWidget {
  final String title;
  final BookingDebugPanelSectionDecoration decoration;
  final Widget child;

  const BookingDebugPanelSection({
    super.key,
    required this.title,
    required this.decoration,
    required this.child,
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
              color: decoration.titleBgColor,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Text(
              title,
              style: decoration.titleStyle,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
              color: decoration.bgColor,
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

class BookingDebugPanelSectionDecoration {
  final TextStyle titleStyle;
  final Color? bgColor;
  final Color? titleBgColor;

  BookingDebugPanelSectionDecoration({
    required this.titleStyle,
    required this.bgColor,
    required this.titleBgColor,
  });
}

class BookingDebugPanelPillContentView extends StatelessWidget {
  final String title;
  final Widget content;
  final BookingDebugPanelPillContentViewDecoration decoration;

  const BookingDebugPanelPillContentView({
    super.key,
    required this.title,
    required this.content,
    required this.decoration,
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
              color: decoration.color,
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
              decoration: BoxDecoration(
                border: const Border(
                  top: BorderSide(width: 1, color: Color(0xFFCED8DD)),
                  bottom: BorderSide(width: 1, color: Color(0xFFCED8DD)),
                ),
                color: decoration.bgColor,
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
                    style: decoration.titleStyle,
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
              color: decoration.color,
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

class BookingDebugPanelPillContentViewDecoration {
  final Color color;
  final TextStyle titleStyle;
  final Color? bgColor;

  BookingDebugPanelPillContentViewDecoration({
    required this.color,
    required this.titleStyle,
    required this.bgColor,
  });
}

class BookingDebugPanelOverviewWidget extends StatelessWidget {
  final BookingDebugPanelRulesTemp rules;
  final BookingDebugPanelOverviewWidgetLabel label;
  final BookingDebugPanelOverviewWidgetDecoration decoration;
  final String Function(String? operatorCode) operatorText;

  const BookingDebugPanelOverviewWidget({
    super.key,
    required this.rules,
    required this.label,
    required this.decoration,
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
          style: decoration.titleStyle,
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

  Widget _generateOverviewViews(BookingDebugPanelRuleElement overview) {
    if (overview.type == 'condition') {
      return BookingDebugPanelConditionView(
        conditions: overview.conditions ?? [],
        success: overview.success,
        failed: overview.failed,
        operatorText: operatorText,
        decoration: decoration.conditionViewDecoration,
        label: label.conditionViewLabel,
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
        BookingDebugPanelRulesAction(
          actionType: overview.actionType,
          components: overview.components,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _generateActionView(BookingDebugPanelRulesAction action) {
    Widget propertyLabel(String tag, String value) {
      return Row(
        children: [
          Text(
            '$tag:',
            style: decoration.tagStyle,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            value,
            style: decoration.valueStyle,
          ),
        ],
      );
    }

    List<Widget> children = [];

    //TODO change children assignment from forEach to use spread operator for more readability
    ///example :
    ///
    /// List<Widget> children = [
    //   // Mapping over `components`
    //   ...?action.components?.expand((component) => [
    //     propertyLabel(
    //       label.conditionViewLabel.componentsConfiguration,
    //       component.component ?? '',
    //     ),
    //     ...?component.properties?.map((property) => Row(
    //       children: [
    //         propertyLabel(
    //           label.conditionViewLabel.propertyLabel,
    //           property.property ?? '',
    //         ),
    //         const SizedBox(width: 8.0),
    //         propertyLabel(
    //           label.conditionViewLabel.valueLabel,
    //           property.value ?? '',
    //         ),
    //       ],
    //     )),
    //   ]),
    //
    //   // Mapping over `placeholders`
    //   ...?action.placeholders?.map((placeholder) => Row(
    //     children: [
    //       propertyLabel(
    //         label.conditionViewLabel.positionLabel,
    //         placeholder.position ?? '',
    //       ),
    //       const SizedBox(width: 8.0),
    //       propertyLabel(
    //         label.conditionViewLabel.contentsLabel,
    //         placeholder.contents ?? '',
    //       ),
    //     ],
    //   )),
    //
    //   // Mapping over `replacements`
    //   ...?action.replacements?.map((replacement) => Row(
    //     children: [
    //       propertyLabel(
    //         label.conditionViewLabel.replaceLabel,
    //         replacement.replace ?? '',
    //       ),
    //       const SizedBox(width: 8.0),
    //       propertyLabel(
    //         label.conditionViewLabel.withLabel,
    //         replacement.replaceWith ?? '',
    //       ),
    //     ],
    //   )),
    //
    //   // Mapping over `variables`
    //   ...?action.variables?.map((variable) => Row(
    //     children: [
    //       propertyLabel(
    //         label.conditionViewLabel.variableLabel,
    //         variable.variable ?? '',
    //       ),
    //       const SizedBox(width: 8.0),
    //       propertyLabel(
    //         label.conditionViewLabel.valueLabel,
    //         variable.value ?? '',
    //       ),
    //     ],
    //   )),
    // ];


    action.components?.forEach(
      (component) {
        children.add(
          propertyLabel(
            label.conditionViewLabel.componentsConfiguration,
            component.component ?? '',
          ),
        );
        component.properties?.forEach(
          (property) {
            children.add(Row(
              children: [
                propertyLabel(
                  label.conditionViewLabel.propertyLabel,
                  property.property ?? '',
                ),
                const SizedBox(width: 8.0),
                propertyLabel(
                  label.conditionViewLabel.valueLabel,
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
              label.conditionViewLabel.positionLabel,
              placeholder.position ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              label.conditionViewLabel.contentsLabel,
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
              label.conditionViewLabel.replaceLabel,
              replacement.replace ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              label.conditionViewLabel.withLabel,
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
              label.conditionViewLabel.variableLabel,
              variable.variable ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              label.conditionViewLabel.valueLabel,
              variable.value ?? '',
            ),
          ],
        ));
      },
    );

    return BookingDebugPanelActionView(
      label:
          '${label.conditionViewLabel.actionLabel}: ${action.actionType ?? ''}',
      decoration: decoration.actionPillContentViewDecoration,
      children: children,
    );
  }
}

class BookingDebugPanelOverviewWidgetLabel {
  final BookingDebugPanelConditionViewLabel conditionViewLabel;

  BookingDebugPanelOverviewWidgetLabel({
    required this.conditionViewLabel,
  });
}

class BookingDebugPanelOverviewWidgetDecoration {
  final BookingDebugPanelConditionViewDecoration conditionViewDecoration;
  final TextStyle titleStyle;
  final TextStyle tagStyle;
  final TextStyle valueStyle;
  final BookingDebugPanelPillContentViewDecoration actionPillContentViewDecoration;

  BookingDebugPanelOverviewWidgetDecoration({
    required this.conditionViewDecoration,
    required this.titleStyle,
    required this.tagStyle,
    required this.valueStyle,
    required this.actionPillContentViewDecoration,
  });
}

class BookingDebugPanelConditionView extends StatelessWidget {
  final List<BookingDebugPanelCondition> conditions;
  final List<BookingDebugPanelRuleElement>? success;
  final List<BookingDebugPanelRuleElement>? failed;
  final BookingDebugPanelConditionViewLabel label;
  final BookingDebugPanelConditionViewDecoration decoration;
  final String Function(String? operatorCode) operatorText;

  const BookingDebugPanelConditionView({
    super.key,
    required this.conditions,
    this.success,
    this.failed,
    required this.label,
    required this.decoration,
    required this.operatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          BookingDebugPanelPillContentView(
            title: label.conditionLabel,
            decoration: decoration.conditionPillContentViewDecoration,
            content: Column(
              children: _generateConditionViews(
                conditions: conditions,
                depth: 0,
                baseColor: Colors.white,
              ),
            ),
          ),
          success != null || failed != null
              ? BookingDebugPanelConditionResultView(
                  title: label.yesConditionLabel,
                  decoration: decoration.positiveConditionResultViewDecoration,
                  initialExpanded: true,
                  children: success
                          ?.map(
                            (e) => _generateElementViews(e),
                          )
                          .toList() ??
                      [
                        BookingDebugPanelEmptyActionView(
                          label: label.noActionLabel,
                          decoration: decoration.emptyActionViewDecoration,
                        )
                      ],
                )
              : const SizedBox(),
          success != null || failed != null
              ? BookingDebugPanelConditionResultView(
                  title: label.noConditionLabel,
                  decoration: decoration.negativeConditionResultViewDecoration,
                  initialExpanded: false,
                  children: failed
                          ?.map(
                            (e) => _generateElementViews(e),
                          )
                          .toList() ??
                      [
                        BookingDebugPanelEmptyActionView(
                          label: label.noActionLabel,
                          decoration: decoration.emptyActionViewDecoration,
                        )
                      ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _generateElementViews(BookingDebugPanelRuleElement element) {
    if (element.type == 'condition') {
      return BookingDebugPanelConditionView(
        conditions: element.conditions ?? [],
        success: element.success,
        failed: element.failed,
        operatorText: operatorText,
        decoration: decoration,
        label: label,
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

  Widget _generateActionView(BookingDebugPanelRulesAction action) {
    Widget propertyLabel(String tag, String value) {
      return RichText(
        text: TextSpan(
          text: '$tag: ',
          style: decoration.tagStyle,
          children: [
            TextSpan(
              text: value,
              style: decoration.valueStyle,
            ),
          ],
        ),
      );
    }

    List<Widget> children = [];

    //TODO if possible, use spread operator instead of forEach like example in TODO line 843
    action.components?.forEach(
      (component) {
        children.add(
          propertyLabel(
            label.componentsConfiguration,
            component.component ?? '',
          ),
        );
        component.properties?.forEach(
          (property) {
            children.add(
              Row(
                children: [
                  propertyLabel(
                    label.propertyLabel,
                    property.property ?? '',
                  ),
                  const SizedBox(width: 8.0),
                  propertyLabel(
                    label.valueLabel,
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
              label.positionLabel,
              placeholder.position ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              label.contentsLabel,
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
              label.replaceLabel,
              replacement.replace ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              label.withLabel,
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
              label.variableLabel,
              variable.variable ?? '',
            ),
            const SizedBox(width: 8.0),
            propertyLabel(
              label.valueLabel,
              variable.value ?? '',
            ),
          ],
        ));
      },
    );

    return BookingDebugPanelActionView(
      label: '${label.actionLabel}: ${action.actionType ?? ''}',
      decoration: decoration.actionPillContentViewDecoration,
      children: children,
    );
  }

  List<Widget> _generateConditionViews(
      {required List<BookingDebugPanelCondition> conditions,
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
        if (i < (conditions.length - 1) &&
            conditions[i + 1].conditionType == 'single') {
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
      child: BookingDebugPanelConditionCompareView(
        label: conditionOperator,
        labelStyle: decoration.conditionCompareLabelStyle,
        child: Container(
          color: bgColor,
          child: Column(
            children: [
              const SizedBox(
                height: 4.0,
              ),
              ...conditions,
              const SizedBox(
                height: 4.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateSingleConditionView({
    required BookingDebugPanelCondition condition,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: BookingDebugPanelConditionCompareView(
        label: condition.conditionOperator ?? '',
        labelStyle: decoration.conditionCompareLabelStyle,
        child: Column(
          children: [
            const SizedBox(
              height: 4.0,
            ),
            BookingDebugPanelConditionCompareDetailsView(
              operand: condition.operand,
              operatorText: operatorText,
              decoration: decoration.conditionCompareDetailsViewDecoration,
            ),
            const SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}

class BookingDebugPanelConditionViewLabel {
  final String actionLabel;
  final String variableLabel;
  final String valueLabel;
  final String replaceLabel;
  final String withLabel;
  final String contentsLabel;
  final String positionLabel;
  final String propertyLabel;
  final String componentsConfiguration;
  final String noActionLabel;
  final String noConditionLabel;
  final String yesConditionLabel;
  final String conditionLabel;

  BookingDebugPanelConditionViewLabel({
    required this.actionLabel,
    required this.variableLabel,
    required this.valueLabel,
    required this.replaceLabel,
    required this.withLabel,
    required this.contentsLabel,
    required this.positionLabel,
    required this.propertyLabel,
    required this.componentsConfiguration,
    required this.noActionLabel,
    required this.noConditionLabel,
    required this.yesConditionLabel,
    required this.conditionLabel,
  });
}

class BookingDebugPanelConditionViewDecoration {
  final TextStyle conditionCompareLabelStyle;
  final TextStyle tagStyle;
  final TextStyle valueStyle;
  final BookingDebugPanelPillContentViewDecoration conditionPillContentViewDecoration;
  final BookingDebugPanelConditionResultViewDecoration positiveConditionResultViewDecoration;
  final BookingDebugPanelConditionResultViewDecoration negativeConditionResultViewDecoration;
  final BookingDebugPanelPillContentViewDecoration actionPillContentViewDecoration;
  final BookingDebugPanelEmptyActionViewDecoration emptyActionViewDecoration;
  final BookingDebugPanelConditionCompareDetailsViewDecoration conditionCompareDetailsViewDecoration;

  BookingDebugPanelConditionViewDecoration({
    required this.conditionCompareLabelStyle,
    required this.tagStyle,
    required this.valueStyle,
    required this.conditionPillContentViewDecoration,
    required this.positiveConditionResultViewDecoration,
    required this.negativeConditionResultViewDecoration,
    required this.actionPillContentViewDecoration,
    required this.emptyActionViewDecoration,
    required this.conditionCompareDetailsViewDecoration,
  });
}

class BookingDebugPanelConditionCompareView extends StatelessWidget {
  final String? label;
  final TextStyle labelStyle;
  final Widget child;

  const BookingDebugPanelConditionCompareView({
    super.key,
    required this.label,
    required this.labelStyle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    bottom: 4.0,
                    left: 8.0,
                  ),
                  child: SizedBox(
                    width: 30,
                    child: Text(
                      label ?? '',
                      style: labelStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox(),
          Expanded(child: child),
        ],
      );
}

class BookingDebugPanelConditionCompareDetailsView extends StatelessWidget {
  final BookingDebugPanelOperand? operand;
  final BookingDebugPanelConditionCompareDetailsViewDecoration decoration;
  final String Function(String? operatorCode) operatorText;

  const BookingDebugPanelConditionCompareDetailsView({
    super.key,
    required this.operand,
    required this.decoration,
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
              BookingDebugPanelTagLabel(
                label: operand?.lhs?.tag ?? '',
                decoration: decoration.lhsTagLabelDecoration,
              ),
              Text(
                operand?.lhs?.value ?? '',
                style: decoration.descriptionTextStyle,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            operatorText.call(operand?.operator),
            style: decoration.operatorTextStyle,
          ),
        ),
        Flexible(
          flex: 2,
          child: Row(
            children: [
              BookingDebugPanelTagLabel(
                label: operand?.rhs?.tag ?? '',
                decoration: decoration.rhsTagLabelDecoration,
              ),
              Expanded(
                child: Text(
                  operand?.rhs?.value ?? '',
                  style: decoration.descriptionTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BookingDebugPanelConditionCompareDetailsViewDecoration {
  final TextStyle descriptionTextStyle;
  final TextStyle operatorTextStyle;
  final BookingDebugPanelTagLabelDecoration lhsTagLabelDecoration;
  final BookingDebugPanelTagLabelDecoration rhsTagLabelDecoration;

  BookingDebugPanelConditionCompareDetailsViewDecoration({
    required this.descriptionTextStyle,
    required this.operatorTextStyle,
    required this.lhsTagLabelDecoration,
    required this.rhsTagLabelDecoration,
  });
}

class BookingDebugPanelTagLabel extends StatelessWidget {
  final String label;
  final BookingDebugPanelTagLabelDecoration decoration;

  const BookingDebugPanelTagLabel({
    super.key,
    required this.label,
    required this.decoration,
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
        color: decoration.bgColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        label,
        style: decoration.labelStyle,
      ),
    );
  }
}

class BookingDebugPanelTagLabelDecoration {
  final Color? bgColor;
  final TextStyle labelStyle;

  BookingDebugPanelTagLabelDecoration({
    required this.bgColor,
    required this.labelStyle,
  });
}

class BookingDebugPanelActionView extends StatelessWidget {
  final String label;
  final List<Widget> children;
  final BookingDebugPanelPillContentViewDecoration decoration;

  const BookingDebugPanelActionView({
    super.key,
    required this.label,
    required this.children,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: BookingDebugPanelPillContentView(
        title: label,
        decoration: decoration,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class BookingDebugPanelConditionResultView extends StatefulWidget {
  final String title;
  final BookingDebugPanelConditionResultViewDecoration decoration;
  final List<Widget> children;
  final bool initialExpanded;

  const BookingDebugPanelConditionResultView({
    super.key,
    required this.title,
    required this.decoration,
    required this.children,
    required this.initialExpanded,
  });

  @override
  State<BookingDebugPanelConditionResultView> createState() => _BookingDebugPanelConditionResultViewState();
}

class _BookingDebugPanelConditionResultViewState extends State<BookingDebugPanelConditionResultView> {
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
      color: widget.decoration.color ?? Colors.grey,
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
          color: widget.decoration.bgColor,
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
                    color: widget.decoration.color,
                    borderRadius: BorderRadius.circular(2.0), // Corner radius
                  ),
                  child: Center(
                    child: Text(
                      isExpanded ? '-' : '+',
                      style: widget.decoration.expandButtonStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(widget.title, style: widget.decoration.titleStyle),
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

class BookingDebugPanelConditionResultViewDecoration {
  final Color? bgColor;
  final Color? color;
  final TextStyle titleStyle;
  final TextStyle expandButtonStyle;

  BookingDebugPanelConditionResultViewDecoration({
    required this.bgColor,
    required this.color,
    required this.titleStyle,
    required this.expandButtonStyle,
  });
}

class BookingDebugPanelExecutedRulesView extends StatelessWidget {
  final BookingDebugPanelRule? rule;
  final BookingDebugPanelExecutedRulesViewLabel label;
  final BookingDebugPanelExecutedRulesViewDecoration decoration;

  const BookingDebugPanelExecutedRulesView({
    super.key,
    required this.rule,
    required this.label,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.title,
          style: decoration.titleStyle,
        ),
        BookingDebugPanelSection(
          title: label.executedRulesText,
          decoration: decoration.subSectionDecoration,
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
        BookingDebugPanelSection(
          title: label.outputActionsText,
          decoration: decoration.subSectionDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _generatePropertiesText(rule),
          ),
        ),
      ],
    );
  }

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
            style: decoration.captionLabelStyle,
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
                  style: decoration.captionLabelStyle,
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
          style: decoration.tagLabelStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          '=',
          style: decoration.captionLabelStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          value,
          style: decoration.valueLabelStyle,
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
          style: decoration.valueLabelStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          '→',
          style: decoration.captionLabelStyle,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          to,
          style: decoration.valueLabelStyle,
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
          style: decoration.tagLabelStyle,
        ),
        const SizedBox(width: 4.0),
        Text(
          '$tag:',
          style: decoration.tagLabelStyle,
        ),
        const SizedBox(width: 4.0),
        Text(
          label.undefined,
          style: decoration.valueLabelStyle,
        ),
        Text(
          '→',
          style: decoration.captionLabelStyle,
        ),
        Text(
          value,
          style: decoration.valueLabelStyle,
        ),
      ],
    );
  }

  List<Widget> _generatePropertiesText(BookingDebugPanelRule? rules) {
    if (rules == null) return [];
    List<Widget> widgets = [];

    //TODO if possible, use spread operator instead of forEach like example in TODO line 843
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

class BookingDebugPanelExecutedRulesViewLabel {
  final String title;
  final String executedRulesText;
  final String outputActionsText;
  final String undefined;

  BookingDebugPanelExecutedRulesViewLabel({
    required this.title,
    required this.executedRulesText,
    required this.outputActionsText,
    required this.undefined,
  });
}

class BookingDebugPanelExecutedRulesViewDecoration {
  final TextStyle captionLabelStyle;
  final TextStyle tagLabelStyle;
  final TextStyle valueLabelStyle;
  final TextStyle titleStyle;
  final BookingDebugPanelSectionDecoration subSectionDecoration;

  BookingDebugPanelExecutedRulesViewDecoration({
    required this.captionLabelStyle,
    required this.tagLabelStyle,
    required this.valueLabelStyle,
    required this.titleStyle,
    required this.subSectionDecoration,
  });
}

class BookingDebugPanelEmptyActionView extends StatelessWidget {
  final String label;
  final BookingDebugPanelEmptyActionViewDecoration decoration;

  const BookingDebugPanelEmptyActionView({
    super.key,
    required this.label,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        alignment: Alignment.centerLeft,
        height: 33.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: decoration.borderColor ?? Colors.grey,
            width: 1.0,
          ),
          color: decoration.bgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          label,
          style: decoration.labelStyle,
        ),
      ),
    );
  }
}

class BookingDebugPanelEmptyActionViewDecoration {
  final Color? borderColor;
  final Color? bgColor;
  final TextStyle labelStyle;

  BookingDebugPanelEmptyActionViewDecoration({
    required this.borderColor,
    required this.bgColor,
    required this.labelStyle,
  });
}

class BookingDebugPanelInformationDetailsView extends StatelessWidget {
  final List<String> details;
  final BookingDebugPanelInformationDetailsViewDecoration decoration;

  const BookingDebugPanelInformationDetailsView({
    super.key,
    required this.details,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: details
          .map(
            (detail) => _pointText(detail),
          ).toList(),
    );
  }

  Widget _pointText(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: TextStyle(
            color: decoration.dotColor,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            text,
            style: decoration.labelStyle,
          ),
        ),
      ],
    );
  }
}

class BookingDebugPanelInformationDetailsViewDecoration {
  final Color? dotColor;
  final TextStyle labelStyle;

  BookingDebugPanelInformationDetailsViewDecoration({
    required this.dotColor,
    required this.labelStyle,
  });
}

class CheckboxView extends StatefulWidget {
  final String label;
  final bool initialValue;
  final CheckboxViewDecoration decoration;

  const CheckboxView({
    super.key,
    required this.label,
    required this.initialValue,
    required this.decoration,
  });

  @override
  State<StatefulWidget> createState() => _CheckboxViewState();
}

class _CheckboxViewState extends State<CheckboxView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked, 
          side: BorderSide(
            color: widget.decoration.borderColor ?? Colors.grey,
            width: 1.0,
          ),
          checkColor: widget.decoration.checkColor,
          activeColor: widget.decoration.activeColor,
          onChanged: (value) => setState(() => isChecked = value!),
        ),
        Text(
          widget.label,
          style: widget.decoration.labelStyle,
        ),
      ],
    );
  }
}

class CheckboxViewDecoration {
  final Color? activeColor;
  final Color? borderColor;
  final Color? checkColor;
  final TextStyle labelStyle;

  CheckboxViewDecoration({
    required this.activeColor,
    required this.borderColor,
    required this.checkColor,
    required this.labelStyle,
  });
}

class BookingDebugPanelExpandablePanel extends StatefulWidget {
  final Widget content;
  final BookingDebugPanelExpandablePanelLabel label;
  final BookingDebugPanelExpandablePanelDecoration decoration;

  const BookingDebugPanelExpandablePanel({
    super.key,
    required this.content,
    required this.label,
    required this.decoration,
  });

  @override
  State<BookingDebugPanelExpandablePanel> createState() => _BookingDebugPanelExpandablePanelState();
}

class _BookingDebugPanelExpandablePanelState extends State<BookingDebugPanelExpandablePanel>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(parent: _controller, curve: Curves.ease);
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleExpanded,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.label.title,
                      style: widget.decoration.titleStyle,
                    ),
                  ),
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
                      widget.label.status,
                      style: widget.decoration.positiveStatusLabelStyle,
                    ),
                  ),
                ],
              ),
            ),
            SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: -1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: widget.content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingDebugPanelExpandablePanelLabel {
  final String title;
  final String status;

  BookingDebugPanelExpandablePanelLabel({
    required this.title,
    required this.status,
  });
}

class BookingDebugPanelExpandablePanelDecoration {
  final Color? positiveStatusColor;
  final TextStyle titleStyle;
  final TextStyle positiveStatusLabelStyle;

  BookingDebugPanelExpandablePanelDecoration({
    required this.positiveStatusColor,
    required this.titleStyle,
    required this.positiveStatusLabelStyle,
  });
}

class BookingDebugPanelScrollableContent extends StatefulWidget {
  final String rulesetId;
  final BookingDebugPanelRulesetsTemp ruleSet;
  final BookingDebugPanelScrollableContentLabel label;
  final BookingDebugPanelScrollableContentDecoration decoration;
  final String Function(String? operatorCode) operatorText;
  final BookingDebugPanelRuleSet? Function(String? rulesetId) ruleSetDetails;

  const BookingDebugPanelScrollableContent({
    super.key, 
    required this.ruleSet,
    required this.rulesetId,
    required this.label,
    required this.decoration,
    required this.operatorText,
    required this.ruleSetDetails,
  });

  @override
  State<BookingDebugPanelScrollableContent> createState() =>
      _BookingDebugPanelScrollableContentState();
}

class _BookingDebugPanelScrollableContentState
    extends State<BookingDebugPanelScrollableContent> {
  late ScrollController _scrollController;
  double _thumbPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateThumbPosition);
  }

  void _updateThumbPosition() {
    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _thumbPosition = _scrollController.offset /
            _scrollController.position.maxScrollExtent;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateThumbPosition);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double itemWidth = 120;
    const double itemMargin = 16;
    const int itemCount = 8;
    const double scrollbarThickness = 10;

    const double contentWidth = itemCount * (itemWidth + itemMargin);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: SizedBox(
            width: 1024,
            child: BookingDebugPanelRulesSetContentView(
              ruleSet: widget.ruleSet,
              rulesetId: widget.rulesetId,
              label: widget.label.rulesSetContentViewLabel,
              decoration: widget.decoration.rulesSetContentViewDecoration,
              operatorText: widget.operatorText,
              ruleSetDetails: widget.ruleSetDetails,
            ),
          ),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final double visibleWidth = constraints.maxWidth;
            final double thumbWidth =
                (visibleWidth / contentWidth) * visibleWidth;
            final double maxThumbOffset = visibleWidth - thumbWidth;
            final double thumbOffset = maxThumbOffset * _thumbPosition;

            return Container(
              height: scrollbarThickness,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: thumbOffset,
                    child: Container(
                      width: thumbWidth.clamp(30, visibleWidth),
                      height: scrollbarThickness,
                      decoration: BoxDecoration(
                        color: widget.decoration.thumbColor ?? Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class BookingDebugPanelScrollableContentLabel {
  final BookingDebugPanelRulesSetContentViewLabel rulesSetContentViewLabel;

  BookingDebugPanelScrollableContentLabel({
    required this.rulesSetContentViewLabel,
  });
}

class BookingDebugPanelScrollableContentDecoration {
  final Color? thumbColor;
  final BookingDebugPanelRulesSetContentViewDecoration rulesSetContentViewDecoration;

  BookingDebugPanelScrollableContentDecoration({
    required this.thumbColor,
    required this.rulesSetContentViewDecoration,
  });
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;
  final Color? bgColor;

  StickyHeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
    this.bgColor,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: bgColor ?? Colors.white,
      child: SizedBox.expand(
        child: child,
      ),
    );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) => false;
}