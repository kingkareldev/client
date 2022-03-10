import 'package:business_contract/mission/game/entities/game_board.dart';
import 'package:business_contract/mission/game/entities/game_cell.dart';
import 'package:business_contract/mission/game/entities/robot_coords.dart';
import 'package:flutter/material.dart';

class GameBoardView extends StatelessWidget {
  final GameBoard gameBoard;
  final RobotCoords robotCoords;

  const GameBoardView({
    required this.gameBoard,
    required this.robotCoords,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _cellPadding = 3;
    const double _cellSize = 50;

    return Container(
      color: Colors.lightBlueAccent.shade100.withOpacity(0.5),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(_cellPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final row in gameBoard.rows)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final cell in row.cells)
                        Container(
                          width: _cellSize,
                          height: _cellSize,
                          margin: const EdgeInsets.all(_cellPadding),
                          color: Colors.red,
                          child: Center(
                            child: _CellWidget(cell: cell),
                          ),
                        )
                    ],
                  )
              ],
            ),
          ),
          Positioned(
            top: 2 * _cellPadding + robotCoords.y * (_cellSize + 2 * _cellPadding), // TODO
            left: 2 * _cellPadding + robotCoords.x * (_cellSize + 2 * _cellPadding),
            child: Container(
              width: _cellSize,
              height: _cellSize,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class _CellWidget extends StatelessWidget {
  final GameCell cell;

  const _CellWidget({required this.cell, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cell is WalkableCell) {
      return const Text("OK");
    }

    if (cell is WallCell) {
      return const Text("W");
    }

    if (cell is HiddenCell) {
      return const Text("B");
    }

    return Container();
  }
}
