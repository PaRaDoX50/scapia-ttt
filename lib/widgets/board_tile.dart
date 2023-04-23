import 'package:flutter/material.dart';
import 'package:tic_tac_toe_scapia/data/tile_state.dart';

class BoardTile extends StatelessWidget {
  final TileState tileState;
  final double dimension;
  final VoidCallback onPressed;

  const BoardTile(
      {super.key,
      required this.tileState,
      required this.dimension,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: _widgetForTileState(),
      ),
    );
  }

  Widget _widgetForTileState() {
    late final Widget widget;

    switch (tileState) {
      case TileState.empty:
        {
          widget = Container(
            decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(.4)),
          );
        }
        break;

      case TileState.cross:
        {
          widget =
              _containerBlueGreyWrapper(Image.asset('assets/images/x.png'));
          // widget = Text('X');
        }
        break;

      case TileState.circle:
        {
          widget =
              _containerBlueGreyWrapper(Image.asset('assets/images/o.png'));
        }
        break;
    }

    return widget;
  }

  Widget _containerBlueGreyWrapper(Widget widget) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(.4)),
      child: Center(child: widget),
    );
  }
}
