import 'package:flutter_test/flutter_test.dart';
import 'package:teste_unitario_um/person.dart';
import 'package:teste_unitario_um/person_bloc.dart';
import 'package:teste_unitario_um/person_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_unitario_um/person_state.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person = Person(id: 0, name: '', age: 25, height: 1.80, weight: 85);

  group('Person List Tests', () {
    test('Shuld return person list', () async {
      when(() => repository.getPersonList())
          .thenAnswer((_) async => <Person>[person, person]);

      bloc.add(PersonEvent.fetch);

      // Emits são utilizados para testar o bloc, na certeza de somente um envio de dados, usar emits
      // expect(bloc, emits());

      // Emits são utilizados para testar o bloc, na certeza de varios envios de dados, usar emitsInOrder
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            // O primeiro envio de dados será o isLoading
            isA<PersonLoadingState>(),
            // O segundo envio de dados será a lista de Person
            isA<PersonListState>()
          ],
        ),
      );
    });

    test('Shuld throw error', () async {
      when(() => repository.getPersonList()).thenThrow(Exception('Deu error'));

      bloc.add(PersonEvent.fetch);

      // Emits são utilizados para testar o bloc, na certeza de somente um envio de dados, usar emits
      // expect(bloc, emits());

      // Emits são utilizados para testar o bloc, na certeza de varios envios de dados, usar emitsInOrder
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            // O primeiro envio de dados será o isLoading
            isA<PersonLoadingState>(),
            // O segundo envio de dados será a lista de Person
            isA<PersonErrorState>()
          ],
        ),
      );
    });
  });
}
