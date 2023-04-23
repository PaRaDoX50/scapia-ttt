import 'package:flutter/material.dart';
import 'package:tic_tac_toe_scapia/data/tile_state.dart';
import 'package:tic_tac_toe_scapia/widgets/board_tile.dart';

class BoardTilesWrap extends StatelessWidget {
  final List<TileState> boardState;
  final Function(int) updateTileStateForIndex;
  const BoardTilesWrap(
      {super.key,
      required this.boardState,
      required this.updateTileStateForIndex});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final boardDimension = MediaQuery.of(context).size.width;
      final tileDimension = boardDimension / 3;

      return SizedBox(
          width: boardDimension,
          height: boardDimension,
          child: Column(
              children: chunk(boardState, 3).asMap().entries.map((entry) {
            final chunkIndex = entry.key;
            final tileStateChunk = entry.value;

            return Row(
              children: tileStateChunk.asMap().entries.map((innerEntry) {
                final innerIndex = innerEntry.key;
                final tileState = innerEntry.value;
                final tileIndex = (chunkIndex * 3) + innerIndex;

                return BoardTile(
                  tileState: tileState,
                  dimension: tileDimension,
                  onPressed: () => updateTileStateForIndex(tileIndex),
                );
              }).toList(),
            );
          }).toList()));
    });
  }
}
