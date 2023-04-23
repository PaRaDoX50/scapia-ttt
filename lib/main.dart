import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe_scapia/data/tile_state.dart';
import 'package:tic_tac_toe_scapia/utils/utils.dart';
import 'package:tic_tac_toe_scapia/widgets/board_tiles_wrap.dart';
import 'package:tic_tac_toe_scapia/widgets/common_app_bar.dart';
import 'package:tic_tac_toe_scapia/widgets/common_text_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  var _boardState = List.filled(9, TileState.empty);

  var _currentTurn = TileState.cross;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: LayoutBuilder(builder: (context, constraints) {
        return MediaQuery(
          data: constraints.maxWidth > 500
              ? MediaQuery.of(context).copyWith(size: const Size(375, 812))
              : MediaQuery.of(context),
          child: Scaffold(
            appBar: const CommonAppBar(title: 'Tic Tac Toe'),
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Stack(children: [
                      BoardTilesWrap(
                          boardState: _boardState,
                          updateTileStateForIndex: _updateTileStateByIndex)
                    ]),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 16)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          _resetGame();
                        },
                        child: const Text('Reset',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _updateTileStateByIndex(int selectedIndex) {
    if (_boardState[selectedIndex] == TileState.empty) {
      setState(() {
        _boardState[selectedIndex] = _currentTurn;
        _currentTurn = _currentTurn == TileState.cross
            ? TileState.circle
            : TileState.cross;
      });

      final winner = checkWinner(_boardState);
      if (winner != null) {
        _showWinnerDialog(winner);
      } else {
        bool isDraw = true;
        for (var element in _boardState) {
          if (element == TileState.empty) {
            isDraw = false;
          }
        }
        if (isDraw) {
          _showDrawDialog();
        }
      }
    }
  }

  void _showWinnerDialog(TileState tileState) {
    final context = navigatorKey.currentState!.overlay!.context;
    showDialog(
        context: context,
        builder: (_) {
          return Stack(
            children: [
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'We have a winner!',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      tileState == TileState.cross ? 'X' : 'O',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ],
                ),
                // title:
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CommonTextButton(
                          onPressed: () {
                            _resetGame();
                            Navigator.of(context).pop();
                          },
                          title: 'Replay'),
                    ),
                  ),
                ],
              ),
              IgnorePointer(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: LottieBuilder.asset('assets/animations/confetti.json',
                      repeat: false),
                ),
              ),
            ],
          );
        });
  }

  void _showDrawDialog() {
    final context = navigatorKey.currentState!.overlay!.context;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: const Text(
              'It\'s a draw!',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            // title:
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CommonTextButton(
                      onPressed: () {
                        _resetGame();
                        Navigator.of(context).pop();
                      },
                      title: 'Replay'),
                ),
              ),
            ],
          );
        });
  }

  void _resetGame() {
    setState(() {
      _boardState = List.filled(9, TileState.empty);
      _currentTurn = TileState.cross;
    });
  }
}
