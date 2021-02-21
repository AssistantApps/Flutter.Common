import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../assistantapps_flutter_common.dart';
import '../../contracts/generated/translationsPerLanguageGraphViewModel.dart';
import '../../helpers/snapshotHelper.dart';

class TranslationsPerLanguageCustomChart extends StatelessWidget {
  Widget graphItemDisplayer(
      BuildContext context, TranslationsPerLanguageGraphViewModel item) {
    return ListTile(
      dense: true,
      leading: Image.asset(
        'icons/flags/png/${item.countryCode}.png',
        package: 'country_icons',
        height: 50,
        width: 50,
      ),
      title: Text(item.name),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: LinearPercentIndicator(
          animation: false,
          lineHeight: 20.0,
          percent: (item.percentage / 100),
          center: Text(
            getTranslations()
                .fromKey(LocaleKey.percentage)
                .replaceAll('{0}', item.percentage.toString()),
            style: TextStyle(color: Colors.black),
          ),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: getTheme().getSecondaryColour(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<
            ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>>(
          future: TranslationApiService().getTranslationsPerLanguageChart(),
          builder: (
            BuildContext context,
            AsyncSnapshot<
                    ResultWithValue<
                        List<TranslationsPerLanguageGraphViewModel>>>
                snapshot,
          ) {
            Widget errorWidget = asyncSnapshotHandler(context, snapshot,
                loader: () => getLoading().loadingIndicator(),
                isValidFunction: (ResultWithValue<
                        List<TranslationsPerLanguageGraphViewModel>>
                    data) {
                  if (snapshot.data.value == null ||
                      snapshot.data.value == null ||
                      snapshot.data.value.length < 1) {
                    return false;
                  }
                  return true;
                });
            if (errorWidget != null) return errorWidget;

            List<TranslationsPerLanguageGraphViewModel> list =
                snapshot.data.value.take(10).toList();

            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: const Color(0xff2c4260),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Column(
                  children: list
                      .map((item) => graphItemDisplayer(context, item))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
