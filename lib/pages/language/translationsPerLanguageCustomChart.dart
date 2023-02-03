import 'package:flutter/material.dart';

import '../../components/common/animation.dart';
import '../../components/common/percent.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/translations_per_language_graph_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/snapshotHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../services/api/translationApiService.dart';

class TranslationsPerLanguageCustomChart extends StatelessWidget {
  const TranslationsPerLanguageCustomChart({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: HorizontalProgressBar(
          percent: (item.percentage / 1),
          animation: false,
          text: Text(
            getTranslations()
                .fromKey(LocaleKey.percentage)
                .replaceAll('{0}', item.percentage.toString()),
            style: const TextStyle(color: Colors.black),
          ),
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
            Widget? errorWidget = asyncSnapshotHandler(context, snapshot,
                loader: () => getLoading().loadingIndicator(),
                isValidFunction: (ResultWithValue<
                        List<TranslationsPerLanguageGraphViewModel>>?
                    data) {
                  if (snapshot.data?.value == null ||
                      snapshot.data?.value == null ||
                      (snapshot.data?.value.isEmpty ?? true)) {
                    return false;
                  }
                  return true;
                });
            if (errorWidget != null) return errorWidget;

            List<TranslationsPerLanguageGraphViewModel> list =
                snapshot.data?.value.take(10).toList() ?? List.empty();

            return animateWidgetIn(
              child: Card(
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
              ),
            );
          },
        ),
      ],
    );
  }
}
