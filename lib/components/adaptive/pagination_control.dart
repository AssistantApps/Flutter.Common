import 'package:flutter/material.dart';

import '../../contracts/enum/locale_key.dart';
import '../../integration/dependency_injection.dart';
import '../common/image.dart';
import './button.dart';

class PaginationControl extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final void Function() next;
  final void Function() prev;

  const PaginationControl({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.next,
    required this.prev,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (currentPage > 1) ...[
          Center(child: PositiveButton(title: '<', onTap: prev))
        ],
        if (currentPage < totalPages) ...[
          Center(child: PositiveButton(title: '>', onTap: next))
        ],
      ],
    );
  }
}

class SmallLoadMorePageButton extends StatelessWidget {
  const SmallLoadMorePageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SmallPageButton(
      title: getTranslations().fromKey(LocaleKey.loadMore),
      icon: Icons.navigate_next,
    );
  }
}

class SmallPageButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const SmallPageButton({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CorrectlySizedImageFromIcon(icon: icon),
      title: Text(title),
    );
  }
}
