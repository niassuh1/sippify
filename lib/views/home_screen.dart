import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/services/weight_provider.dart';
import 'package:glassbean/widgets/dope_panel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          const SliverAppBar(
            forceElevated: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
                top: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DopePanel(
                    headline: 'Weight',
                    child: SfSlider(
                      value: ref.watch(weightProvider.state).state,
                      onChanged: (e) {
                        ref.read(weightProvider.state).state = e.toDouble();
                      },
                      showTicks: true,
                      min: 10,
                      stepSize: 1,
                      interval: 10,
                      max: 50,
                      enableTooltip: true,
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
