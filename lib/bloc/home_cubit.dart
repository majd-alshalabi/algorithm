import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  RedBlueBlankGame? redBlueBlankGame;
  List<ThePossibleDirection> possibleDirection = [];

  void initState(int blockSize) {
    redBlueBlankGame = RedBlueBlankGame(blockSize);
    notify();
  }

  void dispose() {
    redBlueBlankGame = null;
  }

  void showPossibleDirection(List<ThePossibleDirection> li) {
    possibleDirection = li;
    emit(HomeLoading());
    emit(HomeShowPossibleDirection());
  }

  void notify() {
    emit(HomeLoading());
    emit(HomeLoaded());
    showPossibleDirection([]);
  }
}
