import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:flutter/material.dart';

class AbsenceListView extends StatelessWidget {
  const AbsenceListView({
    required this.absenceList,
    required this.userMap,
    required this.scrollController,
    required this.hasMoreItems,
    super.key,
  });

  final List<AbsenceResponseEntity> absenceList;
  final Map<int, String> userMap;
  final ScrollController scrollController;
  final bool hasMoreItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (ctx, index) => index == absenceList.length && hasMoreItems
          ? const AppLoader()
          : _AbsenceListItem(
              absenceResponseEntity: absenceList[index],
              userMap: userMap,
              index: index,
            ),
      itemCount: absenceList.length + (hasMoreItems ? 1 : 0),
    );
  }
}

class _AbsenceListItem extends StatelessWidget {
  const _AbsenceListItem({
    required this.absenceResponseEntity,
    required this.index,
    required this.userMap,
  });

  final AbsenceResponseEntity absenceResponseEntity;
  final int index;
  final Map<int, String> userMap;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expansionAnimationStyle: AnimationStyle(
        curve: Curves.easeIn,
        duration: const Duration(
          seconds: 1,
        ),
      ),
      title: Text(userMap[absenceResponseEntity.userId] ?? '-'),
      leading: CircleAvatar(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              '${absenceResponseEntity.userId}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
      expandedAlignment: Alignment.centerLeft,
      children: [
        buildAbsenceDetail(
          context,
          title: 'Status:',
          trailing: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ChoiceChip(
                  label: Text(
                    absenceResponseEntity.absenceStatus,
                  ),
                  selected: true,
                  selectedShadowColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  showCheckmark: false,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: WidgetStatePropertyAll(
                    absenceResponseEntity.absenceStatusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        buildAbsenceDetail(
          context,
          title: 'Type Of Absence:',
          trailing: Text(
            absenceResponseEntity.absenceType?.isTextNotNullAndNotEmpty == true
                ? absenceResponseEntity.absenceType ?? 'N/A'
                : 'N/A',
          ),
        ),
        buildAbsenceDetail(
          context,
          title: 'Period:',
          trailing: Text(
            absenceResponseEntity.absenceStartDate.isTextNotNullAndNotEmpty ==
                    true
                ? absenceResponseEntity.absenceStartDate ?? '-'
                : '-',
          ),
        ),
        buildAbsenceDetail(
          context,
          title: 'Member Note:',
          trailing: Text(
            absenceResponseEntity.memberNote?.isTextNotNullAndNotEmpty == true
                ? absenceResponseEntity.memberNote ?? '-'
                : '-',
          ),
        ),
        buildAbsenceDetail(
          context,
          title: 'Admitter Note:',
          trailing: Text(
            absenceResponseEntity.admitterNote?.isTextNotNullAndNotEmpty == true
                ? absenceResponseEntity.admitterNote ?? '-'
                : '-',
          ),
        ),
      ],
    );
  }

  Widget buildAbsenceDetail(
    BuildContext context, {
    required String title,
    required Widget trailing,
  }) {
    return ListTile(
      title: Text(
        title,
        style: context.theme.textTheme.titleSmall,
      ),
      subtitle: trailing,
    );

    //   Padding(
    //   padding: const EdgeInsets.all(8),
    //   child:
    //
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         title,
    //         style: context.theme.textTheme.titleSmall,
    //       ),
    //       trailing,
    //     ],
    //   ),
    // );
  }
}
