import 'package:business_contract/story/entities/game/game_cell.dart';
import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final GameCell cell;

  const Cell({required this.cell, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cell is WallCell) {
      return Container(
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: const Text("🏰", style: TextStyle(fontSize: 32)),
      );
    }

    if (cell is ForestCell) {
      return Container(
        color: Colors.green.shade300,
        alignment: Alignment.center,
        child: const Text("🌳", style: TextStyle(fontSize: 32)),
      );
    }

    if (cell is WaterCell) {
      return Container(
        color: Colors.blue.shade200,
        alignment: Alignment.center,
        child: const Text("🌊", style: TextStyle(fontSize: 32)),
      );
    }

    if (cell is WalkableCell) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              for (int i = WalkableCell.maxNumberOfMarks - 1; i >= 0; i--)
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    color:
                    (i < (cell as WalkableCell).numberOfMarks) ? Colors.pink.withOpacity(0.6) : Colors.transparent,
                    margin: const EdgeInsets.only(bottom: 2),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
