import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:flutter/material.dart';

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
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(
                child: const Text(
                  'Debug Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                minHeight: 22,
                maxHeight: 22,
              ),
            ),
            SliverPersistentHeader(
              pinned: false,
              delegate: StickyHeaderDelegate(
                minHeight: 0,
                maxHeight: 80,
                child: Container(
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Text(
                    'This is the description text. It will disappear as you scroll down.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
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
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Hide Ruleset History'),
                    ),
                    const SizedBox(height: 8),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
                minHeight: 150,
                maxHeight: 150,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final String? key = rulesets?.keys.toList()[index];
                  final RulesetsTemp? ruleset = rulesets?[key];
                  return ruleset != null
                      ? CustomExpandablePanel(
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

  StickyHeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Colors.white,
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