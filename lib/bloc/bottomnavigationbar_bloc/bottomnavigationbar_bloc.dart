import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto_app/bloc/bottomnavigationbar_bloc/bottomnavigationbar_event.dart';
import 'package:tobeto_app/bloc/bottomnavigationbar_bloc/bottomnavigationbar_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial());

  @override
  Stream<BottomNavigationState> mapEventToState(
    BottomNavigationEvent event,
  ) async* {
    if (event is BottomNavigationItemTapped) {
      yield BottomNavigationIndexChanged(event.index);
    }
  }
}
