import 'package:business_contract/mission/game/entities/game/game_board.dart';
import 'package:business_contract/mission/game/entities/game/robot_coords.dart';
import 'package:flutter/material.dart';

import 'cell.dart';
import 'robot_cell.dart';

class GameBoardView extends StatelessWidget {
  final GameBoard gameBoard;
  final Coords robotCoords;

  const GameBoardView({
    required this.gameBoard,
    required this.robotCoords,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _cellPadding = 1;
    const double _cellSize = 50;

    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.shade100.withOpacity(0.5)
      ),
      padding: const EdgeInsets.all(_cellSize),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.none,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Stack(
              fit: StackFit.passthrough,
              clipBehavior: Clip.none,
              children: [
                // horizontal coords
                for (int i = 0; i < gameBoard.rows.first.cells.length; i++)
                  Positioned(
                    top: _cellPadding + -1 * (_cellSize + 2 * _cellPadding),
                    left: _cellPadding + i * (_cellSize + 2 * _cellPadding),
                    child: Container(
                      width: _cellSize,
                      height: _cellSize,
                      margin: const EdgeInsets.all(_cellPadding),
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        _columnIndexToString(i),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                // vertical coords
                for (int i = 0; i < gameBoard.rows.length; i++)
                  Positioned(
                    top: _cellPadding + i * (_cellSize + 2 * _cellPadding),
                    left: _cellPadding + -1 * (_cellSize + 2 * _cellPadding),
                    child: Container(
                      width: _cellSize,
                      height: _cellSize,
                      margin: const EdgeInsets.all(_cellPadding),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                        _rowIndexToString(i),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(_cellPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int rowIndex = 0; rowIndex < gameBoard.rows.length; rowIndex++)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int columnIndex = 0; columnIndex < gameBoard.rows[rowIndex].cells.length; columnIndex++)
                              Container(
                                width: _cellSize,
                                height: _cellSize,
                                margin: const EdgeInsets.all(_cellPadding),
                                child: Tooltip(
                                  message: _indexToString(rowIndex: rowIndex, columnIndex: columnIndex),
                                  child: Cell(cell: gameBoard.rows[rowIndex].cells[columnIndex]),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                Positioned(
                  top: _cellPadding + robotCoords.y * (_cellSize + 2 * _cellPadding),
                  left: _cellPadding + robotCoords.x * (_cellSize + 2 * _cellPadding),
                  child: Container(
                    width: _cellSize,
                    height: _cellSize,
                    margin: const EdgeInsets.all(_cellPadding),
                    child: const RobotCell(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  String _indexToString({required int rowIndex, required int columnIndex}) {
    return "${_columnIndexToString(columnIndex)};${_rowIndexToString(rowIndex)}";
  }

  String _rowIndexToString(int index) {
    return index.toString();
  }

  String _columnIndexToString(int index) {
    return String.fromCharCode("a".codeUnitAt(0) + index).toUpperCase();
  }
}
