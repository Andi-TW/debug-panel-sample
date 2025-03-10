import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  final Response response;

  const MainPage({
    super.key,
    required this.response,
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
                      SvgPicture.asset(
                        'assets/bug.svg',
                        width: 16.0,
                        height: 22.0,
                      ),
                      const SizedBox(width: 10.0,),
                      const Expanded(
                        child: Text(
                          'Debug Information',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF0D4689),
                        ),
                        onTap: () {
                          
                        },
                      ),
                    ],
                  ),
                ),
                minHeight: 44,
                maxHeight: 44,
                bgColor: const Color(0xFFF0F3F5),
              ),
            ),
            SliverPersistentHeader(
              pinned: false,
              delegate: StickyHeaderDelegate(
                bgColor: Colors.transparent,
                minHeight: 0,
                maxHeight: 74,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: DebugInformationDetailsView(
                      details: [
                        'App version: 0.0.0',
                        'Ama-Client-Ref:b2232dd1-fe09-4de9-b3b4-12a5a8736e77',
                        'Started at: 2024-05-21T03:41:44.64OX',
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CheckboxView(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith((states) => const Color(0xFF0D4689),),
                          foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white,),
                          textStyle: WidgetStateTextStyle.resolveWith(
                            (states) {
                              return const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              );
                            },
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Hide Ruleset History'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Ruleset Execution History',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF0D4689),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4,),
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
                            hintText: 'Search',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0), // Corner radius
                              borderSide: const BorderSide(
                                color: Color(0xFFCED8DD), // Warna border (#CED8DD)
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                            enabledBorder: OutlineInputBorder( // Border saat TextField aktif
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFCED8DD), // Warna border (#CED8DD)
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                            focusedBorder: OutlineInputBorder( // Border saat TextField fokus
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFCED8DD), // Warna border (#CED8DD)
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SvgPicture.asset(
                                'assets/search.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                            )
                          ),
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
                        child: CustomExpandablePanel(
                            title: ruleset.name ?? '',
                            status: 'APPLIED',
                            content: HorizontalScrollableContent(
                              ruleSet: ruleset,
                              rulesetId: key ?? '',
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

class CheckboxView extends StatefulWidget {
  const CheckboxView({super.key});

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
          side: const BorderSide(
            color: Color(0xFFA7B6BF),
            width: 1.0,
          ),
          checkColor: Colors.white,
          activeColor: const Color(0xFF0D4689),
          onChanged: (value) => setState(() => isChecked = value!),
        ),
        const Text(
          'Show localisation key',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.0,
            color: Color(0xFF0D4689),
          ),
        ),
      ],
    );
  }
}

class DebugInformationDetailsView extends StatelessWidget {
  final List<String> details;

  const DebugInformationDetailsView({
    super.key,
    required this.details,
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
        const Text(
          '•',
          style: TextStyle(
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomExpandablePanel extends StatefulWidget {
  final String title;
  final String status;
  final Widget content;

  const CustomExpandablePanel({
    super.key,
    required this.title,
    required this.status,
    required this.content,
  });

  @override
  State<CustomExpandablePanel> createState() => _CustomExpandablePanelState();
}

class _CustomExpandablePanelState extends State<CustomExpandablePanel>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
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
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
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
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        color: Color(0xFF333333),
                      ),
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
                    child: Text(
                      widget.status,
                      style: const TextStyle(
                        color: Color(0xFF1DB36E),
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

class HorizontalScrollableContent extends StatefulWidget {
  final RulesetsTemp ruleSet;
  final String rulesetId;
  final String Function(String? operatorCode) operatorText;
  final RuleSet? Function(String? rulesetId) ruleSetDetails;

  const HorizontalScrollableContent({
    super.key, 
    required this.ruleSet,
    required this.rulesetId,
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
            child: RulesSetContentView(
              ruleSet: widget.ruleSet,
              rulesetId: widget.rulesetId,
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
                        color: Colors.deepPurple,
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