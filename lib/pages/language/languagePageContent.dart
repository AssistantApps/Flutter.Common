import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../contracts/generated/translationsPerLanguageGraphViewModel.dart';
import '../../helpers/snapshotHelper.dart';

class LanguagePageContent extends StatelessWidget {
  final List<Widget> additionalButtons;
  LanguagePageContent(this.additionalButtons);

  @override
  Widget build(BuildContext context) {
    var widgets = [
      Text(getTranslations().fromKey(LocaleKey.languageContent)),
      emptySpace3x(),
    ];
    widgets.add(FutureBuilder<
        ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>>(
      future: TranslationApiService().getTranslationsPerLanguageChart(),
      builder: (BuildContext context,
          AsyncSnapshot<
                  ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>>
              snapshot) {
        Widget errorWidget = asyncSnapshotHandler(context, snapshot);
        if (errorWidget != null) return errorWidget;

        List<TranslationsPerLanguageGraphViewModel> list = snapshot.data.value;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: const Color(0xff2c4260),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipBottomMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.round().toString(),
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 20,
                  getTitles: (double value) {
                    int index = value.round();
                    try {
                      return list[index].name;
                    } catch (exception) {
                      return 'Unknown';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: list.asMap().entries.map(
                (entry) {
                  int idx = entry.key;
                  TranslationsPerLanguageGraphViewModel val = entry.value;
                  return BarChartGroupData(
                    x: idx,
                    barRods: [
                      BarChartRodData(
                          y: val.percentage.toDouble(),
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  );
                },
              ),
            ),
          ),
        );
      },
    ));
    widgets.addAll(additionalButtons);

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(12),
      children: widgets,
    );
  }
}
