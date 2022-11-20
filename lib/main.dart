import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled3/bloc/home_cubit.dart';
import 'package:untitled3/core/feature/bloc/theme_bloc/theme_cubit.dart';
import 'package:untitled3/core/widget/widgets.dart';
import 'package:untitled3/injection_container.dart';

import 'collection.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocBuilder<ThemeCubit, ThemeData>(
          bloc: sl<ThemeCubit>(),
          builder: (_, theme) {
            return MaterialApp(
              home: TheLevelPage(),
              debugShowCheckedModeBanner: false,
              theme: theme,
            );
          });
    });
  }
}

class TheLevelPage extends StatelessWidget {
  TheLevelPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: const [
              Text(
                "Yellow Blue Blank Game",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                'swap between the Yellow and the blue to win,good Luck',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 1; i < 4; i++)
                      CustomButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyMainScreen(blockSize: i + 1),
                            ),
                          );
                        },
                        buttonName: 'Level $i',
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({Key? key, required this.blockSize}) : super(key: key);

  final int blockSize;
  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  @override
  void initState() {
    super.initState();
    sl<HomeCubit>().initState(widget.blockSize);
  }

  void showTheAlgorithmPath() {
    sl<HomeCubit>().redBlueBlankGame!.thePathThatTheAlgorithmWentFrom =
        sl<HomeCubit>()
            .redBlueBlankGame!
            .thePathThatTheAlgorithmWentFrom
            .reversed
            .toList();

    sl<HomeCubit>().algorithmAns = sl<HomeCubit>()
        .redBlueBlankGame!
        .thePathThatTheAlgorithmWentFrom
        .length;
    Future.forEach(
        sl<HomeCubit>().redBlueBlankGame!.thePathThatTheAlgorithmWentFrom,
        (element) async {
      await Future.delayed(
        const Duration(milliseconds: 100),
        () {
          sl<HomeCubit>().redBlueBlankGame!.theState = element;
          sl<HomeCubit>().notify();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder(
                buildWhen: (previous, current) {
                  if (current is HomeLoaded) {
                    return true;
                  }
                  return false;
                },
                bloc: sl<HomeCubit>(),
                builder: (context, state) {
                  if (sl<HomeCubit>().redBlueBlankGame != null) {
                    return SizedBox(
                      child: Transform.rotate(
                        transformHitTests: true,
                        angle: -math.pi / 4,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: sl<HomeCubit>()
                                .redBlueBlankGame!
                                .theState
                                .current
                                .map((element) {
                              return Expanded(
                                child: Row(
                                  children: element.map((element2) {
                                    switch (element2) {
                                      case TheStatePossibleValue.yellow:
                                        return Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.yellow),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            margin: const EdgeInsets.all(2),
                                          ),
                                        );
                                      case TheStatePossibleValue.blue:
                                        return Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            margin: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.blue),
                                          ),
                                        );
                                      case TheStatePossibleValue.blank:
                                        return Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            margin: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.white),
                                          ),
                                        );
                                      case TheStatePossibleValue.anActiveSpace:
                                        return Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            margin: const EdgeInsets.all(3),
                                            color: Colors.transparent,
                                          ),
                                        );
                                    }
                                  }).toList(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Offstage();
                }),
            BlocBuilder(
              buildWhen: (previous, current) {
                if (current is HomeLoaded) {
                  return true;
                }
                return false;
              },
              bloc: sl<HomeCubit>(),
              builder: (context, state) {
                if (sl<HomeCubit>().algorithmAns != null) {
                  return Column(
                    children: [
                      const Text(
                        "This Algorithm Take",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        sl<HomeCubit>().algorithmAns.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        sl<HomeCubit>().exTime ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                }
                return const Offstage();
              },
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      buttonName: 'Dfs',
                      onTap: () {
                        Stopwatch stopwatch = Stopwatch()..start();
                        sl<HomeCubit>().initState(widget.blockSize);
                        sl<HomeCubit>().redBlueBlankGame!.doDfs();
                        sl<HomeCubit>().exTime =
                            'Dsf executed in ${stopwatch.elapsed} \nand the number of visited state is ${sl<HomeCubit>().redBlueBlankGame!.vis.length}';
                        showTheAlgorithmPath();
                      },
                    ),
                    CustomButton(
                      buttonName: 'Bfs',
                      onTap: () {
                        Stopwatch stopwatch = Stopwatch()..start();
                        sl<HomeCubit>().initState(widget.blockSize);
                        sl<HomeCubit>().redBlueBlankGame!.doBfs();
                        sl<HomeCubit>().exTime =
                            'Bsf executed in ${stopwatch.elapsed}\nand the number of visited state is ${sl<HomeCubit>().redBlueBlankGame!.vis.length}';
                        showTheAlgorithmPath();
                      },
                    ),
                    CustomButton(
                      buttonName: 'Ucs',
                      onTap: () {
                        Stopwatch stopwatch = Stopwatch()..start();
                        sl<HomeCubit>().initState(widget.blockSize);
                        sl<HomeCubit>().redBlueBlankGame!.doUcs();
                        sl<HomeCubit>().exTime =
                            'Ucs executed in ${stopwatch.elapsed}\nand the number of visited state is ${sl<HomeCubit>().redBlueBlankGame!.vis.length}';
                        showTheAlgorithmPath();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  buttonName: 'A*',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  buttonName: 'Reset',
                  onTap: () {
                    sl<HomeCubit>().initState(widget.blockSize);
                    sl<HomeCubit>().notify();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RedBlueBlankGame {
  /// 3 - 4 - 5
  final int theSizeOfEachBlock;

  /// the List that we store all state in it
  TheState theState = TheState();

  /// the state that the current algorithm visited
  List<TheState> vis = [];

  /// the ans path for either algorithm bfs or dfs
  List<TheState> thePathThatTheAlgorithmWentFrom = [];

  /// if the dfs algorithm went for a win state
  bool isWinState = false;

  RedBlueBlankGame(this.theSizeOfEachBlock) {
    theState.current = [];

    /// fill the array initially with the red at the top and the blue at the bottom
    for (int i = 0; i <= theSizeOfEachBlock * 2 - 2; i++) {
      theState.current.add(<TheStatePossibleValue>[]);
      for (int j = 0; j <= theSizeOfEachBlock * 2 - 2; j++) {
        if (i >= theSizeOfEachBlock - 1 && j >= theSizeOfEachBlock - 1) {
          theState.current[i].add(TheStatePossibleValue.yellow);
        } else if (i < theSizeOfEachBlock && j < theSizeOfEachBlock) {
          theState.current[i].add(TheStatePossibleValue.blue);
        } else {
          theState.current[i].add(TheStatePossibleValue.anActiveSpace);
        }
      }
    }
    theState.thePositionOfTheBlankInX = theSizeOfEachBlock - 1;
    theState.thePositionOfTheBlankInY = theSizeOfEachBlock - 1;

    /// initial the blank
    theState.current[theState.thePositionOfTheBlankInX]
        [theState.thePositionOfTheBlankInY] = TheStatePossibleValue.blank;
  }

  bool checkIfItPossibleToMoveTop(int step, TheState li) {
    if (li.thePositionOfTheBlankInX - step >= 0 &&
        li.current[li.thePositionOfTheBlankInX - step]
                [li.thePositionOfTheBlankInY] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  bool checkIfItPossibleToMoveBottom(int step, TheState li) {
    if (li.thePositionOfTheBlankInX + step < theSizeOfEachBlock * 2 - 1 &&
        li.current[li.thePositionOfTheBlankInX + step]
                [li.thePositionOfTheBlankInY] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  bool checkIfItPossibleToMoveLeft(int step, TheState li) {
    if (li.thePositionOfTheBlankInY - step >= 0 &&
        li.current[li.thePositionOfTheBlankInX]
                [li.thePositionOfTheBlankInY - step] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  bool checkIfItPossibleToMoveRight(int step, TheState li) {
    if (li.thePositionOfTheBlankInY + step < theSizeOfEachBlock * 2 - 1 &&
        li.current[li.thePositionOfTheBlankInX]
                [li.thePositionOfTheBlankInY + step] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  moveTop(int step, TheState li) {
    if (checkIfItPossibleToMoveTop(step, li)) {
      TheStatePossibleValue x =
          li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY];
      li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY] =
          li.current[li.thePositionOfTheBlankInX - step]
              [li.thePositionOfTheBlankInY];
      li.current[li.thePositionOfTheBlankInX - step]
          [li.thePositionOfTheBlankInY] = x;
      li.thePositionOfTheBlankInX -= step;

      return li;
    }
    return null;
  }

  moveBottom(int step, TheState li) {
    if (checkIfItPossibleToMoveBottom(step, li)) {
      TheStatePossibleValue x =
          li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY];
      li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY] =
          li.current[li.thePositionOfTheBlankInX + step]
              [li.thePositionOfTheBlankInY];
      li.current[li.thePositionOfTheBlankInX + step]
          [li.thePositionOfTheBlankInY] = x;
      li.thePositionOfTheBlankInX += step;
      return li;
    }
    return null;
  }

  moveLeft(int step, TheState li) {
    if (checkIfItPossibleToMoveLeft(step, li)) {
      TheStatePossibleValue x =
          li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY];
      li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY] =
          li.current[li.thePositionOfTheBlankInX]
              [li.thePositionOfTheBlankInY - step];
      li.current[li.thePositionOfTheBlankInX]
          [li.thePositionOfTheBlankInY - step] = x;
      li.thePositionOfTheBlankInY -= step;
      return li;
    }
    return null;
  }

  moveRight(int step, TheState li) {
    if (checkIfItPossibleToMoveRight(step, li)) {
      TheStatePossibleValue x =
          li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY];
      li.current[li.thePositionOfTheBlankInX][li.thePositionOfTheBlankInY] =
          li.current[li.thePositionOfTheBlankInX]
              [li.thePositionOfTheBlankInY + step];
      li.current[li.thePositionOfTheBlankInX]
          [li.thePositionOfTheBlankInY + step] = x;
      li.thePositionOfTheBlankInY += step;
      return li;
    }
    return null;
  }

  List<ThePossibleDirection> getThePossibleDirection(TheState currentList) {
    List<ThePossibleDirection> li = [];

    if (checkIfItPossibleToMoveRight(1, currentList)) {
      li.add(ThePossibleDirection.right);
    }
    if (checkIfItPossibleToMoveRight(2, currentList)) {
      li.add(ThePossibleDirection.doubleRight);
    }
    if (checkIfItPossibleToMoveLeft(1, currentList)) {
      li.add(ThePossibleDirection.left);
    }
    if (checkIfItPossibleToMoveLeft(2, currentList)) {
      li.add(ThePossibleDirection.doubleLeft);
    }
    if (checkIfItPossibleToMoveTop(1, currentList)) {
      li.add(ThePossibleDirection.top);
    }
    if (checkIfItPossibleToMoveTop(2, currentList)) {
      li.add(ThePossibleDirection.doubleTop);
    }
    if (checkIfItPossibleToMoveBottom(1, currentList)) {
      li.add(ThePossibleDirection.bottom);
    }
    if (checkIfItPossibleToMoveBottom(2, currentList)) {
      li.add(ThePossibleDirection.doubleBottom);
    }

    return li;
  }

  bool win(TheState li) {
    bool check = true;
    for (int i = 0; i <= theSizeOfEachBlock * 2 - 2; i++) {
      for (int j = 0; j <= theSizeOfEachBlock * 2 - 2; j++) {
        if (i == j && i == theSizeOfEachBlock - 1) continue;
        if (i >= theSizeOfEachBlock - 1 &&
            j >= theSizeOfEachBlock - 1 &&
            li.current[i][j] != TheStatePossibleValue.blue) {
          check = false;
        } else if (i < theSizeOfEachBlock &&
            j < theSizeOfEachBlock &&
            li.current[i][j] != TheStatePossibleValue.yellow) {
          check = false;
        }
      }
    }
    return check;
  }

  bool isEqual(TheState list, TheState li) {
    bool check = true;
    for (int i = 0; i <= theSizeOfEachBlock * 2 - 2; i++) {
      for (int j = 0; j <= theSizeOfEachBlock * 2 - 2; j++) {
        if (list.current[i][j] != li.current[i][j]) check = false;
      }
    }
    return check;
  }

  void printCurrentState(TheState list) {
    String out = '';
    for (var element in list.current) {
      for (var element in element) {
        out += '${element.name} ';
      }
      out += '\n';
    }
    if (kDebugMode) {
      print('CURRENT STATE');
      print(out);
    }
  }

  bool checkIfVisited(TheState li2) {
    bool test = false;
    for (var element in vis) {
      if (isEqual(element, li2)) {
        test = true;
        break;
      }
    }
    return test;
  }

  void makeCurrentVisited(TheState li2) {
    vis.add(li2);
  }

  List<TheState> getNextState(TheState li) {
    List<ThePossibleDirection> possible = getThePossibleDirection(li);
    List<TheState> ans = [];
    for (var element in possible) {
      switch (element) {
        case ThePossibleDirection.right:
          ans.add(moveRight(1, li.copy()));
          break;
        case ThePossibleDirection.doubleRight:
          ans.add(moveRight(2, li.copy()));
          break;
        case ThePossibleDirection.left:
          ans.add(moveLeft(1, li.copy()));
          break;
        case ThePossibleDirection.doubleLeft:
          ans.add(moveLeft(2, li.copy()));
          break;
        case ThePossibleDirection.top:
          ans.add(moveTop(1, li.copy()));
          break;
        case ThePossibleDirection.doubleTop:
          ans.add(moveTop(2, li.copy()));
          break;
        case ThePossibleDirection.bottom:
          ans.add(moveBottom(1, li.copy()));
          break;
        case ThePossibleDirection.doubleBottom:
          ans.add(moveBottom(2, li.copy()));
          break;
      }
    }
    return ans;
  }

  void doDfs() {
    vis.clear();
    thePathThatTheAlgorithmWentFrom.clear();
    isWinState = false;
    dfs(theState);
  }

  void dfs(TheState li) {
    if (checkIfVisited(li) || isWinState) return;
    if (win(li)) {
      isWinState = true;
      while (li.par != null) {
        thePathThatTheAlgorithmWentFrom.add(li);
        li = li.par!;
      }
      return;
    }
    makeCurrentVisited(li);
    List<TheState> nextState = getNextState(li);
    for (var element in nextState) {
      dfs(element);
    }
  }

  void doBfs() {
    vis.clear();
    thePathThatTheAlgorithmWentFrom.clear();
    isWinState = false;
    bfs();
  }

  void bfs() {
    Queue<TheState> qe = Queue();
    qe.add(theState);
    while (qe.isNotEmpty) {
      TheState current = qe.first;
      if (win(current)) {
        while (current.par != null) {
          thePathThatTheAlgorithmWentFrom.add(current.copy());
          current = current.par!;
        }
        break;
      }
      qe.removeFirst();
      if (checkIfVisited(current)) continue;
      makeCurrentVisited(current);
      List<TheState> nextState = getNextState(current);
      for (var element in nextState) {
        qe.add(element);
      }
    }
  }

  void doUcs() {
    vis.clear();
    thePathThatTheAlgorithmWentFrom.clear();
    isWinState = false;
    bfs();
  }

  void ucs() {
    PriorityQueue<TheState> qe =
        PriorityQueue<TheState>((a, b) => b.cost.compareTo(a.cost));
    qe.enQueue(theState);
    while (qe.isNotEmpty) {
      TheState current = qe.peek!;
      if (win(current)) {
        while (current.par != null) {
          thePathThatTheAlgorithmWentFrom.add(current.copy());
          current = current.par!;
        }
        break;
      }
      qe.deQueue();
      if (checkIfVisited(current)) continue;
      makeCurrentVisited(current);
      List<TheState> nextState = getNextState(current);
      for (var element in nextState) {
        qe.enQueue(element);
      }
    }
  }
}

class TheState {
  List<List<TheStatePossibleValue>> current = [];
  int thePositionOfTheBlankInX = -1;
  int thePositionOfTheBlankInY = -1;
  int cost = 0;
  TheState? par;

  TheState copy() {
    TheState theState = TheState();
    theState.thePositionOfTheBlankInX = thePositionOfTheBlankInX;
    theState.thePositionOfTheBlankInY = thePositionOfTheBlankInY;
    theState.cost = cost + 1;
    int i = 0;
    for (var element in current) {
      theState.current.add([]);
      for (var element in element) {
        theState.current[i].add(element);
      }
      i++;
    }
    theState.par = this;
    return theState;
  }

  TheState copyPar() {
    TheState theState = TheState();
    theState.thePositionOfTheBlankInX = thePositionOfTheBlankInX;
    theState.thePositionOfTheBlankInY = thePositionOfTheBlankInY;
    theState.cost = cost;
    int i = 0;
    for (var element in current) {
      theState.current.add([]);
      for (var element in element) {
        theState.current[i].add(element);
      }
      i++;
    }
    return theState;
  }
}

/// an enum to know what the current field contain
enum TheStatePossibleValue { yellow, blue, blank, anActiveSpace }

/// every possible direction we can go to
enum ThePossibleDirection {
  left,
  doubleLeft,
  right,
  doubleRight,
  top,
  doubleTop,
  bottom,
  doubleBottom
}

enum Algorithm { dfs, bfs }
