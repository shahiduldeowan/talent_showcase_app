import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'main_state.dart';
part 'main_cubit.freezed.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void selecteItem(int index) {
    if (state.currentIndex != index) emit(state.copyWith(currentIndex: index));
  }
}
