import 'dart:convert';

import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingDebugPanelPage extends StatelessWidget {
  final DebugPanelResponse response;
  final BookingDebugPanelPageLabel label;
  final BookingDebugPanelPageDecoration decoration;
  final VoidCallback onTapRulesButton;
  final VoidCallback onTapCloseButton;

  const BookingDebugPanelPage({
    super.key,
    required this.response,
    required this.label,
    required this.decoration,
    required this.onTapRulesButton,
    required this.onTapCloseButton,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, RulesetsTemp>? rulesets =
        response.debug?.adminRules?.dictionaries?.rulesets;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F3F5),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      decoration.titleIcon,
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          label.titleLabel,
                          style: decoration.titleStyle,
                        ),
                      ),
                      InkWell(
                        onTap: onTapCloseButton,
                        child: decoration.closeIcon,
                      ),
                    ],
                  ),
                ),
                minHeight: 44,
                maxHeight: 44,
                bgColor: const Color(0xFFF0F3F5),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DebugInformationDetailsView(
                  decoration: decoration.debugInformationDetailsViewDecoration,
                  details: const [
                    'App version: 0.0.0',
                    'Ama-Client-Ref:b2232dd1-fe09-4de9-b3b4-12a5a8736e77',
                    'Started at: 2024-05-21T03:41:44.64OX',
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxView(
                      label: label.showLocalisationLabel,
                      initialValue: false,
                      decoration: decoration.checkboxViewDecoration,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        // Will change with the existing pilled button
                        style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith(
                            (states) => const Color(0xFF0D4689),
                          ),
                          foregroundColor: WidgetStateColor.resolveWith(
                            (states) => Colors.white,
                          ),
                          textStyle: WidgetStateTextStyle.resolveWith(
                            (states) {
                              return const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              );
                            },
                          ),
                        ),
                        onPressed: onTapRulesButton,
                        child: Text(label.hideHistoryLabel),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        label.executionHistoryLabel,
                        style: decoration.executionHistoryLabelStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: label.searchLabel,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFCED8DD),
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFCED8DD),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFCED8DD),
                                  width: 1.0,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: decoration.searchIcon,
                              ),
                              hintStyle: decoration.searchHintStyle),
                        ),
                      ),
                    ),
                  ],
                ),
                minHeight: 200,
                maxHeight: 200,
                bgColor: const Color(0xFFF0F3F5),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final String? key = rulesets?.keys.toList()[index];
                  final RulesetsTemp? ruleset = rulesets?[key];
                  return ruleset != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DebugPanelExpandablePanel(
                            label: DebugPanelExpandablePanelLabel(
                              title: ruleset.name ?? '',
                              status: 'APPLIED',
                            ),
                            decoration: decoration.expandablePanelDecoration,
                            content: HorizontalScrollableContent(
                              ruleSet: ruleset,
                              rulesetId: key ?? '',
                              thumbColor: decoration.thumbColor,
                              operatorText: (operatorCode) {
                                return response.debug?.adminRules?.dictionaries
                                        ?.operators?[operatorCode ?? ''] ??
                                    '';
                              },
                              ruleSetDetails: (rulesetId) {
                                return response.debug?.adminRules?.rulesets
                                    ?.firstWhere(
                                  (element) => element.rulesetId == rulesetId,
                                );
                              },
                            ),
                          ),
                        )
                      : const SizedBox();
                },
                childCount: rulesets?.keys.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingDebugPanelPageLabel {
  final String titleLabel;
  final String showLocalisationLabel;
  final String hideHistoryLabel;
  final String executionHistoryLabel;
  final String searchLabel;

  BookingDebugPanelPageLabel({
    required this.titleLabel,
    required this.showLocalisationLabel,
    required this.hideHistoryLabel,
    required this.executionHistoryLabel,
    required this.searchLabel,
  });
}

class BookingDebugPanelPageDecoration {
  final DebugInformationDetailsViewDecoration debugInformationDetailsViewDecoration;
  final CheckboxViewDecoration checkboxViewDecoration;
  final TextStyle titleStyle;
  final TextStyle executionHistoryLabelStyle;
  final TextStyle searchHintStyle;
  final Widget searchIcon;
  final DebugPanelExpandablePanelDecorationImpl expandablePanelDecoration;
  final Color? thumbColor;
  final Widget titleIcon;
  final Widget closeIcon;

  BookingDebugPanelPageDecoration({
    required this.debugInformationDetailsViewDecoration,
    required this.checkboxViewDecoration,
    required this.titleStyle,
    required this.executionHistoryLabelStyle,
    required this.searchHintStyle,
    required this.searchIcon,
    required this.expandablePanelDecoration,
    required this.thumbColor,
    required this.titleIcon,
    required this.closeIcon,
  });
}

class BookingDebugPanelPageDecorationImpl
    implements BookingDebugPanelPageDecoration {
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

class DebugPanelDetailsView extends StatelessWidget {
  final DebugPanelResponse response;
  final BookingDebugPanelRuleSetViewLabel label;
  final BookingDebugPanelRuleSetViewDecoration decoration;

  const DebugPanelDetailsView({
    super.key,
    required this.response,
    required this.label,
    required this.decoration,
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
                  return BookingDebugPanelRuleSetView(
                    initialExpanded: true,
                    rulesetId: e.key,
                    ruleSet: e.value,
                    label: label,
                    decoration: decoration,
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

class BookingDebugPanelRuleSetView extends StatefulWidget {
  final bool initialExpanded;
  final String rulesetId;
  final RulesetsTemp ruleSet;
  final BookingDebugPanelRuleSetViewLabel label;
  final BookingDebugPanelRuleSetViewDecoration decoration;
  final String Function(String? operatorCode) operatorText;
  final RuleSet? Function(String? rulesetId) ruleSetDetails;

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
                  style: widget.decoration.titleStyle,
                )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: widget.decoration.statusColor ?? Colors.grey,
                        width: 1.0,
                      )),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  child: Text(
                    'APPLIED',
                    style: widget.decoration.statusStyle,
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
  final TextStyle statusStyle;
  final Color? statusColor;

  BookingDebugPanelRuleSetViewDecoration({
    required this.titleStyle,
    required this.statusStyle,
    required this.statusColor,
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
  TextStyle get statusStyle => const TextStyle(
        color: Color(0xFF1DB36E),
        fontWeight: FontWeight.w700,
        fontSize: 10.0,
      );

  @override
  Color? get statusColor => const Color(0xFF1DB36E);
}

class BookingDebugPanelRulesSetContentView extends StatelessWidget {
  final RulesetsTemp ruleSet;
  final String rulesetId;
  final BookingDebugPanelRulesSetContentViewLabel label;
  final BookingDebugPanelRulesSetContentViewDecoration decoration;
  final String Function(String? operatorCode) operatorText;
  final RuleSet? Function(String? rulesetId) ruleSetDetails;

  const BookingDebugPanelRulesSetContentView({
    super.key,
    required this.ruleSet,
    required this.rulesetId,
    required this.label,
    required this.decoration,
    required this.operatorText,
    required this.ruleSetDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DebugPanelSection(
          title: label.rulesOverviewText,
          decoration: DebugPanelSectionDecorationImpl(),
          child: Column(
            children: ruleSet.rules?.entries
                    .map(
                      (rule) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: BookingDebugPanelOverviewWidget(
                          rules: rule.value,
                          decoration: BookingDebugPanelOverviewWidgetDecorationImpl(),
                          label: BookingDebugPanelOverviewWidgetLabel(
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
                          operatorText: operatorText,
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        DebugPanelSection(
          decoration: DebugPanelSectionDecorationImpl(),
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
        DebugPanelSection(
          title: label.outputActionsText,
          decoration: DebugPanelSectionDecorationImpl(),
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
        DebugPanelSection(
          title: label.outputActionsText,
          decoration: DebugPanelSectionDecorationImpl(),
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
        DebugPanelSection(
          title: label.outputActionsText,
          decoration: DebugPanelSectionDecorationImpl(),
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
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ExecutedRulesView(
                        rule: newRules,
                        label: ExecutedRulesViewLabel(
                          title: rules.value.name ?? '',
                          executedRulesText: label.executedRulesText,
                          outputActionsText: label.outputActionsText,
                          undefined: label.undefined,
                        ),
                        decoration: ExecutedRulesViewDecorationImpl(),
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

  BookingDebugPanelRulesSetContentViewDecoration({
    required this.captionLabelStyle,
    required this.tagLabelStyle,
    required this.valueLabelStyle,
  });
}

class BookingDebugPanelRulesSetContentViewDecorationImpl implements BookingDebugPanelRulesSetContentViewDecoration {
  @override
  TextStyle get captionLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  @override
  TextStyle get tagLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF0066B3),
      );

  @override
  TextStyle get valueLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1DB36E),
      );
}

class DebugPanelSection extends StatelessWidget {
  final String title;
  final Widget child;
  final DebugPanelSectionDecoration decoration;

  const DebugPanelSection({
    super.key,
    required this.title,
    required this.child,
    required this.decoration,
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

class DebugPanelSectionDecoration {
  final TextStyle titleStyle;
  final Color? bgColor;
  final Color? titleBgColor;

  DebugPanelSectionDecoration({
    required this.titleStyle,
    required this.bgColor,
    required this.titleBgColor,
  });
}

class DebugPanelSectionDecorationImpl implements DebugPanelSectionDecoration {
  @override
  Color? get bgColor => const Color(0xFFFFFFFF);

  @override
  TextStyle get titleStyle => const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
                color: Colors.black,
              );
  
  @override
  Color? get titleBgColor => const Color(0xFFE1E7EA);
}

class SubDebugPanelSectionDecorationImpl implements DebugPanelSectionDecoration {
  @override
  Color? get bgColor => const Color(0xFFFFFFFF);

  @override
  TextStyle get titleStyle => const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
                color: Colors.black,
              );
  
  @override
  Color? get titleBgColor => const Color(0xFFFCF5E6);
}

class PillContentView extends StatelessWidget {
  final String title;
  final Widget content;
  final PillContentViewDecoration decoration;

  const PillContentView({
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

class PillContentViewDecoration {
  final Color color;
  final TextStyle titleStyle;
  final Color? bgColor;

  PillContentViewDecoration({
    required this.color,
    required this.titleStyle,
    required this.bgColor,
  });
}

class ConditionPillContentViewDecorationImpl implements PillContentViewDecoration {
  @override
  Color get color => const Color(0xFFE6A935);
  
  @override
  TextStyle get titleStyle => const TextStyle(
        color: Color(0xFFE6A935),
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );
                    
  @override
  Color? get bgColor => Colors.white;
}

class ActionPillContentViewDecorationImpl implements PillContentViewDecoration {
  @override
  Color get color => const Color(0xFF0066B3);

  @override
  TextStyle get titleStyle => const TextStyle(
        color: Color(0xFF0066B3),
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );

  @override
  Color? get bgColor => Colors.white;
}

class BookingDebugPanelOverviewWidget extends StatelessWidget {
  final RulesTemp rules;
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

  Widget _generateOverviewViews(RuleElement overview) {
    if (overview.type == 'condition') {
      return BookingDebugPanelConditionView(
        conditions: overview.conditions ?? [],
        success: overview.success,
        failed: overview.failed,
        operatorText: operatorText,
        decoration: BookingDebugPanelConditionViewDecorationImpl(),
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
      label: '${label.conditionViewLabel.actionLabel}: ${action.actionType ?? ''}',
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

  BookingDebugPanelOverviewWidgetDecoration({
    required this.conditionViewDecoration,
    required this.titleStyle,
    required this.tagStyle,
    required this.valueStyle,
  });
}

class BookingDebugPanelOverviewWidgetDecorationImpl
    implements BookingDebugPanelOverviewWidgetDecoration {
  @override
  BookingDebugPanelConditionViewDecoration get conditionViewDecoration =>
      BookingDebugPanelConditionViewDecorationImpl();

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        color: Color(0xFF333333),
      );

  @override
  TextStyle get tagStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        color: Color(0xFFA7B6BF),
      );

  @override
  TextStyle get valueStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 10,
        color: Color(0xFF333333),
      );
}

class BookingDebugPanelConditionView extends StatelessWidget {
  final List<Condition> conditions;
  final List<RuleElement>? success;
  final List<RuleElement>? failed;
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
          PillContentView(
            title: label.conditionLabel,
            decoration: ConditionPillContentViewDecorationImpl(),
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
                  title: label.yesConditionLabel,
                  decoration: GreenConditionResultViewDecorationImpl(),
                  initialExpanded: true,
                  children: success
                          ?.map(
                            (e) => _generateElementViews(e),
                          )
                          .toList() ??
                      [
                        EmptyActionView(
                          label: label.noActionLabel,
                          decoration: EmptyActionViewDecorationImpl(),
                        )
                      ],
                )
              : const SizedBox(),
          success != null || failed != null
              ? ConditionResultView(
                  title: label.noConditionLabel,
                  decoration: RedConditionResultViewDecorationImpl(),
                  initialExpanded: false,
                  children: failed
                          ?.map(
                            (e) => _generateElementViews(e),
                          )
                          .toList() ??
                      [
                        EmptyActionView(
                          label: label.noActionLabel,
                          decoration: EmptyActionViewDecorationImpl(),
                        )
                      ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _generateElementViews(RuleElement element) {
    if (element.type == 'condition') {
      return BookingDebugPanelConditionView(
        conditions: element.conditions ?? [],
        success: element.success,
        failed: element.failed,
        operatorText: operatorText,
        decoration: BookingDebugPanelConditionViewDecorationImpl(),
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

  Widget _generateActionView(RulesAction action) {
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
      child: ConditionCompareView(
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
    required Condition condition,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ConditionCompareView(
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
              decoration:
                  BookingDebugPanelConditionCompareDetailsViewDecorationImpl(),
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

  BookingDebugPanelConditionViewDecoration({
    required this.conditionCompareLabelStyle,
    required this.tagStyle,
    required this.valueStyle,
  });
}

class BookingDebugPanelConditionViewDecorationImpl
    implements BookingDebugPanelConditionViewDecoration {
  @override
  TextStyle get conditionCompareLabelStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        color: Color(0xFFE6A935),
      );

  @override
  TextStyle get tagStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        color: Color(0xFFA7B6BF),
      );

  @override
  TextStyle get valueStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 10,
        color: Color(0xFF333333),
      );
}

class ConditionCompareView extends StatelessWidget {
  final String? label;
  final TextStyle labelStyle;
  final Widget child;

  const ConditionCompareView({
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
  final Operand? operand;
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
                decoration: BookingDebugPanelTagLabelDecorationImpl(
                  backgroundColor: decoration.lhsTagColor,
                ),
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
                decoration: BookingDebugPanelTagLabelDecorationImpl(
                  backgroundColor: decoration.rhsTagColor,
                ),
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
  final Color? lhsTagColor;
  final Color? rhsTagColor;

  BookingDebugPanelConditionCompareDetailsViewDecoration({
    required this.descriptionTextStyle,
    required this.operatorTextStyle,
    required this.lhsTagColor,
    required this.rhsTagColor,
  });
}

class BookingDebugPanelConditionCompareDetailsViewDecorationImpl
    implements BookingDebugPanelConditionCompareDetailsViewDecoration {
  @override
  TextStyle get descriptionTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 10,
        color: Color(0xFF333333),
      );

  @override
  TextStyle get operatorTextStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
        color: Color(0xFFD1223E),
      );

  @override
  Color? get lhsTagColor => const Color(0xFFA7B6BF);

  @override
  Color? get rhsTagColor => const Color(0xFF1DB36E);
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

class BookingDebugPanelTagLabelDecorationImpl
    implements BookingDebugPanelTagLabelDecoration {
  final Color? backgroundColor;

  BookingDebugPanelTagLabelDecorationImpl({required this.backgroundColor});

  @override
  Color? get bgColor => backgroundColor;

  @override
  TextStyle get labelStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        color: Colors.white,
      );
}

class BookingDebugPanelActionView extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const BookingDebugPanelActionView({
    super.key,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: PillContentView(
        title: label,
        decoration: ActionPillContentViewDecorationImpl(),
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
  final ConditionResultViewDecoration decoration;
  final List<Widget> children;
  final bool initialExpanded;

  const ConditionResultView({
    super.key,
    required this.title,
    required this.decoration,
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

class ConditionResultViewDecoration {
  final Color? bgColor;
  final Color? color;
  final TextStyle titleStyle;
  final TextStyle expandButtonStyle;

  ConditionResultViewDecoration({
    required this.bgColor,
    required this.color,
    required this.titleStyle,
    required this.expandButtonStyle,
  });
}

class RedConditionResultViewDecorationImpl
    implements ConditionResultViewDecoration {
  @override
  Color? get bgColor => const Color(0xFFFCEDF0);

  @override
  TextStyle get expandButtonStyle => const TextStyle(
        color: Colors.white,
        fontSize: 8.0,
      );

  @override
  Color? get color => const Color(0xFFD1223E);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10.0,
        color: Color(0xFFD1223E),
      );
}

class GreenConditionResultViewDecorationImpl
    implements ConditionResultViewDecoration {
  @override
  Color? get bgColor => const Color(0xFFEAF8F8);

  @override
  TextStyle get expandButtonStyle => const TextStyle(
        color: Colors.white,
        fontSize: 8.0,
      );

  @override
  Color? get color => const Color(0xFF00AFAD);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10.0,
        color: Color(0xFF00AFAD),
      );
}

class ExecutedRulesView extends StatelessWidget {
  final Rule? rule;
  final ExecutedRulesViewLabel label;
  final ExecutedRulesViewDecoration decoration;

  const ExecutedRulesView({
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
        DebugPanelSection(
          title: label.executedRulesText,
          decoration: SubDebugPanelSectionDecorationImpl(),
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
          title: label.outputActionsText,
          decoration: SubDebugPanelSectionDecorationImpl(),
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

class ExecutedRulesViewLabel {
  final String title;
  final String executedRulesText;
  final String outputActionsText;
  final String undefined;

  ExecutedRulesViewLabel({
    required this.title,
    required this.executedRulesText,
    required this.outputActionsText,
    required this.undefined,
  });
}

class ExecutedRulesViewDecoration {
  final TextStyle captionLabelStyle;
  final TextStyle tagLabelStyle;
  final TextStyle valueLabelStyle;
  final TextStyle titleStyle;

  ExecutedRulesViewDecoration({
    required this.captionLabelStyle,
    required this.tagLabelStyle,
    required this.valueLabelStyle,
    required this.titleStyle,
  });
}

class ExecutedRulesViewDecorationImpl implements ExecutedRulesViewDecoration {
  @override
  TextStyle get captionLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  @override
  TextStyle get tagLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF0066B3),
      );

  @override
  TextStyle get valueLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1DB36E),
      );

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1F4074),
      );
}

class EmptyActionView extends StatelessWidget {
  final String label;
  final EmptyActionViewDecoration decoration;

  const EmptyActionView({
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

class EmptyActionViewDecoration {
  final Color? borderColor;
  final Color? bgColor;
  final TextStyle labelStyle;

  EmptyActionViewDecoration({
    required this.borderColor,
    required this.bgColor,
    required this.labelStyle,
  });
}

class EmptyActionViewDecorationImpl implements EmptyActionViewDecoration {
  @override
  Color? get bgColor => const Color(0xFFFAFBFC);

  @override
  Color? get borderColor => const Color(0xFFCED8DD);

  @override
  TextStyle get labelStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        color: Color(0xFFCED8DD),
      );
}

class DebugInformationDetailsView extends StatelessWidget {
  final List<String> details;
  final DebugInformationDetailsViewDecoration decoration;

  const DebugInformationDetailsView({
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

class DebugInformationDetailsViewDecoration {
  final Color? dotColor;
  final TextStyle labelStyle;

  DebugInformationDetailsViewDecoration({
    required this.dotColor,
    required this.labelStyle,
  });
}

class DebugInformationDetailsViewDecorationImpl
    implements DebugInformationDetailsViewDecoration {
  @override
  Color? get dotColor => const Color(0xFF333333);

  @override
  TextStyle get labelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: Color(0xFF333333),
      );
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

class DebugPanelExpandablePanel extends StatefulWidget {
  final Widget content;
  final DebugPanelExpandablePanelLabel label;
  final DebugPanelExpandablePanelDecoration decoration;

  const DebugPanelExpandablePanel({
    super.key,
    required this.content,
    required this.label,
    required this.decoration,
  });

  @override
  State<DebugPanelExpandablePanel> createState() => _DebugPanelExpandablePanelState();
}

class _DebugPanelExpandablePanelState extends State<DebugPanelExpandablePanel>
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
                          color: widget.decoration.statusColor ?? Colors.grey,
                          width: 1.0,
                        )),
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 10,
                    ),
                    child: Text(
                      widget.label.status,
                      style: TextStyle(
                        color: widget.decoration.statusColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                      ),
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

class DebugPanelExpandablePanelLabel {
  final String title;
  final String status;

  DebugPanelExpandablePanelLabel({
    required this.title,
    required this.status,
  });
}

class DebugPanelExpandablePanelDecoration {
  final Color? statusColor;
  final TextStyle titleStyle;

  DebugPanelExpandablePanelDecoration({
    required this.statusColor,
    required this.titleStyle,
  });
}

class DebugPanelExpandablePanelDecorationImpl implements DebugPanelExpandablePanelDecoration {
  @override
  Color? get statusColor => const Color(0xFF1DB36E);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        color: Color(0xFF333333),
      );
}

class HorizontalScrollableContent extends StatefulWidget {
  final RulesetsTemp ruleSet;
  final String rulesetId;
  final Color? thumbColor;
  final String Function(String? operatorCode) operatorText;
  final RuleSet? Function(String? rulesetId) ruleSetDetails;

  const HorizontalScrollableContent({
    super.key, 
    required this.ruleSet,
    required this.rulesetId,
    this.thumbColor,
    required this.operatorText,
    required this.ruleSetDetails,
  });

  @override
  State<HorizontalScrollableContent> createState() =>
      _HorizontalScrollableContentState();
}

class _HorizontalScrollableContentState
    extends State<HorizontalScrollableContent> {
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
              label: BookingDebugPanelRulesSetContentViewLabel(
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
              decoration: BookingDebugPanelRulesSetContentViewDecorationImpl(),
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
                        color: widget.thumbColor ?? Colors.grey,
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