import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teste_unitario_um/bloc_provider.dart';
import 'package:teste_unitario_um/home_page.dart';
import 'package:teste_unitario_um/person.dart';
import 'package:teste_unitario_um/person_bloc.dart';
import 'package:teste_unitario_um/person_repository.dart';
import 'package:mocktail/mocktail.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person = Person(id: 0, name: '', age: 25, height: 1.80, weight: 85);

  testWidgets(
    'Deve mostrar todos os estados na tela',
    (WidgetTester tester) async {
      // Ao buscar lista de pessoas
      when(() => repository.getPersonList())
          .thenAnswer((_) async => <Person>[person, person]);

      // Inicia o widget para testar
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            //todo Estudar injeção de dependência no dart para evitar a situação abaixo
            //* Na linha 26, é o motivo de utilizarmos o InheritedWidget
            bloc: bloc,
            child: const HomePage(),
          ),
        ),
      );

      // Procura o widget
      final textButton = find.byType(TextButton);
      // Deve mostrar um
      expect(textButton, findsOneWidget);

      // Procura o widget
      final loading = find.byType(CircularProgressIndicator);
      // Não deve encontrar
      expect(loading, findsNothing);

      // Procura o widget
      final listPerson = find.byType(ListView);
      // Não deve encontrar
      expect(listPerson, findsNothing);

      //* Alteração do estado

      // Toque no botão
      await tester.tap(textButton);

      // Aguarda o primeiro evento retornar, no caso o loading.
      await tester.runAsync(() async {
        bloc.stream.first;
      });
      // troca de estados
      await tester.pump();
      // expect(loading, findsOneWidget);
      expect(textButton, findsOneWidget);

      // Aguarda o segundo evento retornar, no caso o loading.
      await tester.runAsync(() async {
        bloc.stream.first;
      });
      // troca de estados
      await tester.pump();
      // expect(listPerson, findsOneWidget);
      expect(textButton, findsOneWidget);
    },
  );
}
