import 'package:flutter/material.dart';

class StyledBottomSheet extends Container {
  final Color? backgroundColor;
  final Widget? sheetHandleIcon;
  final EdgeInsetsGeometry? sheetPadding;
  final double? maxHeight;
  final Widget? content;
  final bool isExpanded;

  StyledBottomSheet(
      {this.maxHeight,
      required this.backgroundColor,
      this.sheetHandleIcon,
      this.sheetPadding,
      this.content,
      this.isExpanded = true,
      super.key})
      : super(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 22,
                  child: Center(child: sheetHandleIcon ?? Container()),
                ),
                maxHeight != null
                    ? Padding(
                        padding: sheetPadding ??
                            const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 0),
                        child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: maxHeight),
                            child: content ?? Container()))
                    : Flexible(
                        fit: isExpanded ? FlexFit.tight : FlexFit.loose,
                        child: Padding(
                          padding: sheetPadding ??
                              const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 0),
                          child: content ?? Container(),
                        ),
                      )
              ],
            ));
}