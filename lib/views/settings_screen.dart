import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/widgets/dope_panel.dart';
import 'package:glassbean/widgets/option_tabs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          forceElevated: true,
          foregroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 24, horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DopePanel(
                  headlineSize: HeadlineSize.Small,
                  headline: 'App Theme',
                ),
                OptionTabs(tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.light_mode_rounded,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Light',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dark_mode_rounded,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Dark',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings_rounded,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Dark',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ])
              ],
            ),
          ),
        )
      ]),
    );
  }
}
