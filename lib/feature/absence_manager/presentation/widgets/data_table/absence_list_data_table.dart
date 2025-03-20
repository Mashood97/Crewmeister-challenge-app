import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/widget/responsive.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AbsenceListDataTable extends StatelessWidget {
  const AbsenceListDataTable({
    required this.absenceList,
    super.key,
  });

  final List<AbsenceResponseEntity> absenceList;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Absence Manager',
          ),
          SizedBox(
            width: getResponsiveValue(context, 200),
            child: Card(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Total Absences: ',
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w200,
                    ),
                    children: [
                      TextSpan(
                        text: '${absenceList.length}',
                        style: context.theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      columns: const [
        DataColumn2(
          label: Text('ID'),
        ),
        DataColumn2(
          label: Text('Member name'),
        ),
        DataColumn2(
          label: Text('Type of absence'),
        ),
        DataColumn2(
          label: Text('Period'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Member note'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text('Status'),
        ),
        DataColumn2(
          label: Text('Admitter note'),
          size: ColumnSize.L,
        ),
      ],
      source: _AbsenceDataTableDataSource(
        absenceList: absenceList,
      ),
      horizontalMargin: 20,
      dataRowHeight: 80,
      autoRowsToHeight: true,
      columnSpacing: 0,
      wrapInCard: false,
      renderEmptyRowsInTheEnd: false,
      minWidth: 1001,
    );
  }
}

class _AbsenceDataTableDataSource extends DataTableSource {
  _AbsenceDataTableDataSource({
    required this.absenceList,
  });

  final List<AbsenceResponseEntity> absenceList;

  @override
  DataRow? getRow(int index) {
    final item = absenceList[index];
    return DataRow2.byIndex(
      index: index,
      selected: index.isOdd,
      cells: [
        DataCell(
          CircleAvatar(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  '${absenceList[index].userId}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ),
        const DataCell(
          Text(
            'Member Name',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        DataCell(
          Text(
            item.absenceType ?? '-',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        DataCell(
          Text(
            item.absenceStartDate ?? '-',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        DataCell(
          Text(
            item.memberNote ?? 'N/A',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        DataCell(
          ChoiceChip(
            label: Text(
              item.absenceStatus,
            ),
            selected: true,
            selectedShadowColor: Colors.transparent,
            shadowColor: Colors.transparent,
            showCheckmark: false,
            color: WidgetStatePropertyAll(
              item.absenceStatusColor,
            ),
          ),
        ),
        DataCell(
          Text(
            item.admitterNote ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => absenceList.length;

  @override
  int get selectedRowCount => 0;
}
