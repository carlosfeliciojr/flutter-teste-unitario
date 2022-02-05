// Define o timeout do suite para o tempo determinado
@Timeout(Duration(seconds: 45))

// Caso seja necessário pular/skipar o suite inteiro
// @Skip('Feature ainda não foi concluída')

import 'package:flutter_test/flutter_test.dart';

void main() {
  //* init state de cada teste
  setUp(() {
    print("Inicia o teste");
  });

  //* dispose do teste
  tearDown(() {
    print("Destrói o teste");
  });

  //* init state do suite
  setUpAll(() {
    print("Inicia o suite");
  });

  //* dispose do suite
  tearDownAll(() {
    print("Destroi o suite");
  });

  test('is worked', () {
    const name = 'Carlos';
    expect(name, isA<String>()); // Verifica através de generics o tipo
    expect(name, equals('Carlos')); // Verifica se é igual
    expect(name, isNotNull); // Verifica se não é nulo
    expect(name, contains('los')); // Verifica se contém

    // Verifica um array de Matcher
    expect(
      name,
      allOf([isA<String>(), equals('Carlos'), isNotNull, contains('los')]),
    );
  });

  // Teste para verificar um erro esperado
  test('throw error', () {
    expect(() => int.parse('x'), throwsException);
  });

  test('throw timeout error', () {
    expect(() => int.parse('x'), throwsException);
  }, skip: 'Falta terminar os casos de teste');

  // Taggear um teste ou uma suite, significa definir prioridades
  test('throw timeout error', () {
    expect(() => int.parse('x'), throwsException);
  }, tags: 'web');

  //! Para executar testes no flutter para um plataforma específica e uma tag definida
  //! executar: flutter test -t web -d chrome "test\other_test.dart"
}
