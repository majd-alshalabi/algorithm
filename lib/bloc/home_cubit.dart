import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  RedBlueBlankGame? redBlueBlankGame;
  int? algorithmAns;
  String? exTime;
  void initState(int blockSize) {
    redBlueBlankGame = RedBlueBlankGame(blockSize);
    algorithmAns = null;
    exTime = null;
    notify();
  }

  void dispose() {
    exTime = null;
    redBlueBlankGame = null;
    algorithmAns = null;
  }

  void notify() {
    emit(HomeLoading());
    emit(HomeLoaded());
  }
}
