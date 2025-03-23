import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class PeriodView extends StatelessWidget {
  const PeriodView({
    required this.startDate,
    required this.endDate,
    super.key,
  });

  final String? startDate;
  final String? endDate;

  @override
  Widget build(BuildContext context) {
    return Text(
      startDate.isTextNotNullAndNotEmpty == true &&
              endDate.isTextNotNullAndNotEmpty == true
          ? DateTime.parse(
                    endDate ?? DateTime.now().toIso8601String(),
                  )
                      .difference(DateTime.parse(
                        startDate ?? DateTime.now().toIso8601String(),
                      ))
                      .inDays ==
                  0
              ? '${startDate?.getFormattedDate}\n${endDate.getFormattedDate}\n1 Day'
              : '${startDate.getFormattedDate}\n${endDate.getFormattedDate}\n${DateTime.parse(
                  endDate ?? DateTime.now().toIso8601String(),
                ).difference(DateTime.parse(
                    startDate ?? DateTime.now().toIso8601String(),
                  )).inDays} Days'
          : '-',
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }
}
