import 'package:flutter/material.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ExcelLikePage extends StatefulWidget {
  const ExcelLikePage({super.key});

  @override
  _ExcelLikePageState createState() => _ExcelLikePageState();
}

class _ExcelLikePageState extends State<ExcelLikePage> {
  late final PlutoGridStateManager _stateManager;

  final List<PlutoColumn> _columns = List.generate(
    10,
        (index) => PlutoColumn(
      title: String.fromCharCode(65 + index), // Generate column titles A, B, C, ...
      field: 'column_$index',
      type: PlutoColumnType.text(),
      enableSorting: false, // Disable sorting on column header click
    ),
  );

  final List<PlutoRow> _rows = List.generate(
    20,
        (rowIndex) => PlutoRow(
      cells: {
        'row_name': PlutoCell(value: '${rowIndex + 1}'), // Numeric row name
        ...{ for (var colIndex in List.generate(10, (colIndex) => colIndex)) 'column_$colIndex' : PlutoCell(value: 'R${rowIndex + 1}C${colIndex + 1}') },
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excel-Like Table')),
      body: PlutoGrid(
        columns: [
          PlutoColumn(
            title: 'Row',
            field: 'row_name',
            type: PlutoColumnType.text(),
            readOnly: true, // Row names should not be editable
            width: 70,
            enableSorting: false, // Disable sorting on row header
          ),
          ..._columns
        ],
        rows: _rows,
        onChanged: (PlutoGridOnChangedEvent event) {
        },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _stateManager = event.stateManager;
          _stateManager.setSelectingMode(PlutoGridSelectingMode.cell); // Enable cell selection mode
        },
        configuration: PlutoGridConfiguration(
          style: PlutoGridStyleConfig(
            gridBackgroundColor: Colors.white,
            gridBorderRadius: BorderRadius.circular(10),
          ),
          shortcut: PlutoGridShortcut(
            actions: {
              ...PlutoGridShortcut.defaultActions,
            },
          ),
          enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveDown,
        ),
      ),
    );
  }
}