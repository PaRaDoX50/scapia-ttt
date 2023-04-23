import 'package:tic_tac_toe_scapia/data/tile_state.dart';

TileState? checkWinner(List<TileState> boardState) {
  winnerForMatch(a, b, c) {
    if (boardState[a] != TileState.empty) {
      if ((boardState[a] == boardState[b]) &&
          (boardState[b] == boardState[c])) {
        return boardState[a];
      }
    }
    return null;
  }

  final checks = [
    winnerForMatch(0, 1, 2),
    winnerForMatch(3, 4, 5),
    winnerForMatch(6, 7, 8),
    winnerForMatch(0, 3, 6),
    winnerForMatch(1, 4, 7),
    winnerForMatch(2, 5, 8),
    winnerForMatch(0, 4, 8),
    winnerForMatch(2, 4, 6),
  ];

  TileState? winner;
  for (int i = 0; i < checks.length; i++) {
    if (checks[i] != null) {
      winner = checks[i];
      break;
    }
  }

  return winner;
}
