import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled3/bloc/home_cubit.dart';
import 'package:untitled3/core/feature/bloc/theme_bloc/theme_cubit.dart';
import 'package:untitled3/injection_container.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: const [
              Text(
                "rED BLuE BLaNK GAmE",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text('swap between the red and the blue to win,good Luck'),
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
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyMainScreen(blockSize: i + 1),
                            ),
                          );
                        },
                        child: Text('Level $i'),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(hintText: "custom game level"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyMainScreen(
                              blockSize: int.parse(controller.text)),
                        ),
                      );
                    },
                    child: const Text('let\'s go'),
                  )
                ],
              )
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sl<HomeCubit>()
                          .redBlueBlankGame!
                          .theArrayList
                          .map((element) {
                        return Expanded(
                          child: Row(
                            children: element.map((element2) {
                              switch (element2) {
                                case TheStatePossibleValue.red:
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(1),
                                      color: Colors.red,
                                    ),
                                  );
                                case TheStatePossibleValue.blue:
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(1),
                                      color: Colors.blue,
                                    ),
                                  );
                                case TheStatePossibleValue.blank:
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(1),
                                      color: Colors.yellow,
                                    ),
                                  );
                                case TheStatePossibleValue.anActiveSpace:
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(3),
                                      color: Colors.grey,
                                    ),
                                  );
                              }
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
                return const Offstage();
              }),
          BlocBuilder(
            bloc: sl<HomeCubit>(),
            buildWhen: (previous, current) {
              if (current is HomeShowPossibleDirection) return true;
              return false;
            },
            builder: (context, state) {
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          sl<HomeCubit>().redBlueBlankGame!.moveTop(2);
                          sl<HomeCubit>().notify();
                        },
                        child: Text(
                          'DoubleTop',
                          style: state is HomeShowPossibleDirection &&
                                  sl<HomeCubit>()
                                      .possibleDirection
                                      .contains(ThePossibleDirection.doubleTop)
                              ? const TextStyle(color: Colors.red)
                              : null,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          sl<HomeCubit>().redBlueBlankGame!.moveTop(1);
                          sl<HomeCubit>().notify();
                        },
                        child: Text(
                          'Top',
                          style: state is HomeShowPossibleDirection &&
                                  sl<HomeCubit>()
                                      .possibleDirection
                                      .contains(ThePossibleDirection.top)
                              ? const TextStyle(color: Colors.red)
                              : null,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextButton(
                            onPressed: () {
                              sl<HomeCubit>().redBlueBlankGame!.moveLeft(2);
                              sl<HomeCubit>().notify();
                            },
                            child: Text(
                              'DoubleLeft',
                              style: state is HomeShowPossibleDirection &&
                                      sl<HomeCubit>()
                                          .possibleDirection
                                          .contains(
                                              ThePossibleDirection.doubleLeft)
                                  ? const TextStyle(color: Colors.red)
                                  : null,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              sl<HomeCubit>().redBlueBlankGame!.moveLeft(1);
                              sl<HomeCubit>().notify();
                            },
                            child: Text(
                              'Left',
                              style: state is HomeShowPossibleDirection &&
                                      sl<HomeCubit>()
                                          .possibleDirection
                                          .contains(ThePossibleDirection.left)
                                  ? const TextStyle(color: Colors.red)
                                  : null,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            sl<HomeCubit>().showPossibleDirection(
                                sl<HomeCubit>()
                                    .redBlueBlankGame!
                                    .getThePossibleDirection());
                          },
                          child: const Text(
                            'Get Possible Dir',
                            style: TextStyle(fontSize: 8),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              sl<HomeCubit>().redBlueBlankGame!.moveRight(1);
                              sl<HomeCubit>().notify();
                            },
                            child: Text(
                              'Right',
                              style: state is HomeShowPossibleDirection &&
                                      sl<HomeCubit>()
                                          .possibleDirection
                                          .contains(ThePossibleDirection.right)
                                  ? const TextStyle(color: Colors.red)
                                  : null,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextButton(
                            onPressed: () {
                              sl<HomeCubit>().redBlueBlankGame!.moveRight(2);
                              sl<HomeCubit>().notify();
                            },
                            child: Text(
                              'DoubleRight',
                              style: state is HomeShowPossibleDirection &&
                                      sl<HomeCubit>()
                                          .possibleDirection
                                          .contains(
                                              ThePossibleDirection.doubleRight)
                                  ? const TextStyle(color: Colors.red)
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          sl<HomeCubit>().redBlueBlankGame!.moveBottom(1);
                          sl<HomeCubit>().notify();
                        },
                        child: Text(
                          'Bottom',
                          style: state is HomeShowPossibleDirection &&
                                  sl<HomeCubit>()
                                      .possibleDirection
                                      .contains(ThePossibleDirection.bottom)
                              ? const TextStyle(color: Colors.red)
                              : null,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          sl<HomeCubit>().redBlueBlankGame!.moveBottom(2);
                          sl<HomeCubit>().notify();
                        },
                        child: Text(
                          'DoubleBottom',
                          style: state is HomeShowPossibleDirection &&
                                  sl<HomeCubit>().possibleDirection.contains(
                                      ThePossibleDirection.doubleBottom)
                              ? const TextStyle(color: Colors.red)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RedBlueBlankGame {
  /// 3 - 4 - 5
  final int theSizeOfEachBlock;

  /// the List that we store all state in it
  List<List<TheStatePossibleValue>> theArrayList = [];

  /// the current position of the blank
  int thePositionOfTheBlankInX = -1;
  int thePositionOfTheBlankInY = -1;

  RedBlueBlankGame(this.theSizeOfEachBlock) {
    thePositionOfTheBlankInX = theSizeOfEachBlock - 1;
    thePositionOfTheBlankInY = theSizeOfEachBlock - 1;

    /// fill the array initially with the red at the top and the blue at the bottom
    for (int i = 0; i <= theSizeOfEachBlock * 2 - 2; i++) {
      theArrayList.add(<TheStatePossibleValue>[]);
      for (int j = 0; j <= theSizeOfEachBlock * 2 - 2; j++) {
        if (i >= theSizeOfEachBlock - 1 && j >= theSizeOfEachBlock - 1) {
          theArrayList[i].add(TheStatePossibleValue.red);
        } else if (i < theSizeOfEachBlock && j < theSizeOfEachBlock) {
          theArrayList[i].add(TheStatePossibleValue.blue);
        } else {
          theArrayList[i].add(TheStatePossibleValue.anActiveSpace);
        }
      }
    }

    /// initial the blank
    theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY] =
        TheStatePossibleValue.blank;
  }

  bool checkIfItPossibleToMoveTop(int step) {
    if (thePositionOfTheBlankInX - step >= 0 &&
        theArrayList[thePositionOfTheBlankInX - step]
                [thePositionOfTheBlankInY] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  bool checkIfItPossibleToMoveBottom(int step) {
    if (thePositionOfTheBlankInX + step < theSizeOfEachBlock * 2 - 1 &&
        theArrayList[thePositionOfTheBlankInX + step]
                [thePositionOfTheBlankInY] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  bool checkIfItPossibleToMoveLeft(int step) {
    if (thePositionOfTheBlankInY - step >= 0 &&
        theArrayList[thePositionOfTheBlankInX]
                [thePositionOfTheBlankInY - step] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  bool checkIfItPossibleToMoveRight(int step) {
    if (thePositionOfTheBlankInY + step < theSizeOfEachBlock * 2 - 1 &&
        theArrayList[thePositionOfTheBlankInX]
                [thePositionOfTheBlankInY + step] !=
            TheStatePossibleValue.anActiveSpace) {
      return true;
    }
    return false;
  }

  moveTop(int step) {
    if (checkIfItPossibleToMoveTop(step)) {
      TheStatePossibleValue x =
          theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY];
      theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY] =
          theArrayList[thePositionOfTheBlankInX - step]
              [thePositionOfTheBlankInY];
      theArrayList[thePositionOfTheBlankInX - step][thePositionOfTheBlankInY] =
          x;
      thePositionOfTheBlankInX -= step;
    }
  }

  moveBottom(int step) {
    if (checkIfItPossibleToMoveBottom(step)) {
      TheStatePossibleValue x =
          theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY];
      theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY] =
          theArrayList[thePositionOfTheBlankInX + step]
              [thePositionOfTheBlankInY];
      theArrayList[thePositionOfTheBlankInX + step][thePositionOfTheBlankInY] =
          x;
      thePositionOfTheBlankInX += step;
    }
  }

  moveLeft(int step) {
    if (checkIfItPossibleToMoveLeft(step)) {
      TheStatePossibleValue x =
          theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY];
      theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY] =
          theArrayList[thePositionOfTheBlankInX]
              [thePositionOfTheBlankInY - step];
      theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY - step] =
          x;
      thePositionOfTheBlankInY -= step;
    }
  }

  moveRight(int step) {
    if (checkIfItPossibleToMoveRight(step)) {
      TheStatePossibleValue x =
          theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY];
      theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY] =
          theArrayList[thePositionOfTheBlankInX]
              [thePositionOfTheBlankInY + step];
      theArrayList[thePositionOfTheBlankInX][thePositionOfTheBlankInY + step] =
          x;
      thePositionOfTheBlankInY += step;
    }
  }

  List<ThePossibleDirection> getThePossibleDirection() {
    List<ThePossibleDirection> li = [];
    if (checkIfItPossibleToMoveBottom(1)) li.add(ThePossibleDirection.bottom);
    if (checkIfItPossibleToMoveBottom(2)) {
      li.add(ThePossibleDirection.doubleBottom);
    }
    if (checkIfItPossibleToMoveLeft(1)) li.add(ThePossibleDirection.left);
    if (checkIfItPossibleToMoveLeft(2)) li.add(ThePossibleDirection.doubleLeft);
    if (checkIfItPossibleToMoveRight(1)) li.add(ThePossibleDirection.right);
    if (checkIfItPossibleToMoveRight(2)) {
      li.add(ThePossibleDirection.doubleRight);
    }
    if (checkIfItPossibleToMoveTop(1)) li.add(ThePossibleDirection.top);
    if (checkIfItPossibleToMoveTop(2)) li.add(ThePossibleDirection.doubleTop);
    return li;
  }

  bool win() {
    bool check = true;
    for (int i = 0; i <= theSizeOfEachBlock * 2 - 2; i++) {
      theArrayList.add(<TheStatePossibleValue>[]);
      for (int j = 0; j <= theSizeOfEachBlock * 2 - 2; j++) {
        if (i >= theSizeOfEachBlock - 1 &&
            j >= theSizeOfEachBlock - 1 &&
            theArrayList[i][j] != TheStatePossibleValue.blue) {
          check = false;
        } else if (i < theSizeOfEachBlock &&
            j < theSizeOfEachBlock &&
            theArrayList[i][j] != TheStatePossibleValue.red) {
          check = false;
        } else {
          theArrayList[i].add(TheStatePossibleValue.anActiveSpace);
        }
      }
    }
    return check;
  }

  bool isEqual(List<List<TheStatePossibleValue>> list) {
    bool check = true;
    for (int i = 0; i <= theSizeOfEachBlock * 2 - 2; i++) {
      theArrayList.add(<TheStatePossibleValue>[]);
      for (int j = 0; j <= theSizeOfEachBlock * 2 - 2; j++) {
        if (list != theArrayList) check = false;
      }
    }
    return check;
  }
}

/// an enum to know what the current field contain
enum TheStatePossibleValue { red, blue, blank, anActiveSpace }

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
