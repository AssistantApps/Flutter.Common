import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../contracts/generated/translationsPerLanguageGraphViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/snapshotHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../services/api/translationApiService.dart';

const ellipsesText = '...';
const numMaxChars = 7;

class TranslationsPerLanguageFLChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<
        ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>>(
      future: TranslationApiService().getTranslationsPerLanguageChart(),
      builder: (
        BuildContext context,
        AsyncSnapshot<
                ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>>
            snapshot,
      ) {
        Widget? errorWidget = asyncSnapshotHandler(
          context,
          snapshot,
          loader: () => getLoading().loadingIndicator(),
        );
        if (errorWidget != null) return Container();

        List<TranslationsPerLanguageGraphViewModel> list =
            snapshot.data?.value.take(7).toList() ?? List.empty();

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: const Color(0xff2c4260),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 120,
                minY: 0,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: const EdgeInsets.all(0),
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
                    margin: 10,
                    rotateAngle: 90,
                    showTitles: true,
                    getTextStyles: (innerCtx, value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    getTitles: (double value) {
                      int index = value.round();
                      try {
                        String name = list[index].name;
                        if (name.length > numMaxChars) {
                          return name.substring(0, numMaxChars) + ellipsesText;
                        }
                        return name;
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
                        BarChartRodData(y: val.percentage.toDouble(), colors: [
                          Colors.lightBlueAccent,
                          Colors.greenAccent
                        ])
                      ],
                      showingTooltipIndicators: [0],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
