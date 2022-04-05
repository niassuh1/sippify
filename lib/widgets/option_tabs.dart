import 'package:flutter/material.dart';

class OptionTabs extends StatelessWidget {
  final List<Widget> tabs;
  final void Function(int)? onTab;
  final int? value;
  const OptionTabs({Key? key, required this.tabs, this.onTab, this.value = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.5),
        color: Colors.black.withOpacity(0.08),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: DefaultTabController(
          length: tabs.length,
          initialIndex: value!,
          child: TabBar(
            automaticIndicatorColorAdjustment: false,
            onTap: onTab,
            padding: EdgeInsets.all(4),
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22.5),
            ),
            overlayColor: MaterialStateProperty.resolveWith((states) {
              return Colors.transparent;
            }),
            labelColor: Colors.black,
            tabs: tabs.map((e) => Tab(child: e)).toList(),
          ),
        ),
      ),
    );
  }
}
