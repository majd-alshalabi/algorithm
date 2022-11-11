import 'package:get_it/get_it.dart';
import 'package:untitled3/bloc/home_cubit.dart';
import 'package:untitled3/core/feature/bloc/theme_bloc/theme_cubit.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => HomeCubit());
  sl.registerLazySingleton(() => ThemeCubit());
}
