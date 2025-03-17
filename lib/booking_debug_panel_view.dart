import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:flutter/material.dart';

class BookingDebugPanelPage extends StatelessWidget {
  final BookingDebugPanelResponse response;
  final BookingDebugPanelDictionaries dictionaries;
  final BookingDebugPanelPageLabel label;
  final BookingDebugPanelPageDecoration decoration;
  final VoidCallback onTapRulesButton;
  final VoidCallback onTapCloseButton;

  const BookingDebugPanelPage({
    super.key,
    required this.response,
    required this.dictionaries,
    required this.label,
    required this.decoration,
    required this.onTapRulesButton,
    required this.onTapCloseButton,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: decoration.backgroundColor,
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
                bgColor: decoration.backgroundColor,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DebugInformationDetailsView(
                  decoration: decoration.debugInformationDetailsViewDecoration,
                  details: [
                    '${label.appVersionLabel}: 0.0.0',
                    '${label.clientRefLabel}: b2232dd1-fe09-4de9-b3b4-12a5a8736e77',
                    '${label.startedDateLabel}: 2024-05-21T03:41:44.64OX',
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
                bgColor: decoration.backgroundColor,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final String? key = dictionaries.rulesets?.keys.toList()[index];
                  final BookingDebugPanelRulesetsTemp? ruleset = dictionaries.rulesets?[key];
                  return ruleset != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DebugPanelExpandablePanel(
                            label: DebugPanelExpandablePanelLabel(
                              title: ruleset.name ?? '',
                              status: label.positiveStatusLabel,
                            ),
                            decoration: decoration.expandablePanelDecoration,
                            content: HorizontalScrollableContent(
                              ruleSet: ruleset,
                              rulesetId: key ?? '',
                              thumbColor: decoration.thumbColor,
                              operatorText: (operatorCode) {
                                return dictionaries.operators?[operatorCode ?? ''] ?? '';
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
                childCount: dictionaries.rulesets?.keys.length ?? 0,
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
  final String positiveStatusLabel;
  final String appVersionLabel;
  final String clientRefLabel;
  final String startedDateLabel;

  BookingDebugPanelPageLabel({
    required this.titleLabel,
    required this.showLocalisationLabel,
    required this.hideHistoryLabel,
    required this.executionHistoryLabel,
    required this.searchLabel,
    required this.positiveStatusLabel,
    required this.appVersionLabel,
    required this.clientRefLabel,
    required this.startedDateLabel,
  });
}

class BookingDebugPanelPageDecoration {
  final Color? backgroundColor;
  final Color? thumbColor;
  final TextStyle titleStyle;
  final TextStyle executionHistoryLabelStyle;
  final TextStyle searchHintStyle;
  final Widget searchIcon;
  final Widget titleIcon;
  final Widget closeIcon;
  final DebugInformationDetailsViewDecoration debugInformationDetailsViewDecoration;
  final CheckboxViewDecoration checkboxViewDecoration;
  final DebugPanelExpandablePanelDecoration expandablePanelDecoration;

  BookingDebugPanelPageDecoration({
    required this.backgroundColor,
    required this.thumbColor,
    required this.titleStyle,
    required this.executionHistoryLabelStyle,
    required this.searchHintStyle,
    required this.searchIcon,
    required this.titleIcon,
    required this.closeIcon,
    required this.debugInformationDetailsViewDecoration,
    required this.checkboxViewDecoration,
    required this.expandablePanelDecoration,
  });
}