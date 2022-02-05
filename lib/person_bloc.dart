import 'package:bloc/bloc.dart';
import 'package:teste_unitario_um/person_repository.dart';
import 'package:teste_unitario_um/person_state.dart';

enum PersonEvent { clear, fetch }

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository repository;

  PersonBloc(this.repository) : super(PersonListState([])) {
    //! Forma depreciada de informar eventos no bloc
    // PersonBloc(this.repository) : super(PersonListState([]));

    // Stream<PersonState> mapEventToState(PersonEvent event) async* {
    //   if (event == PersonEvent.clear) {
    //     yield PersonListState([]);
    //   } else if (event == PersonEvent.fetch) {
    //     yield PersonLoadingState();
    //     try {
    //       final list = await repository.getPersonList();
    //       yield PersonListState(list);
    //     } on Exception catch (e) {
    //       yield PersonErrorState(e);
    //     }
    //   }
    // }

    on<PersonEvent>((event, emit) async {
      if (event == PersonEvent.clear) {
        emit(PersonListState([]));
      } else if (event == PersonEvent.fetch) {
        emit(PersonLoadingState());
        try {
          final list = await repository.getPersonList();
          emit(PersonListState(list));
        } on Exception catch (e) {
          emit(PersonErrorState(e));
        }
      }
    });
  }
}
