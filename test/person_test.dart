import 'package:flutter_test/flutter_test.dart';
import 'package:teste_unitario_um/person.dart';

//* Para executar todos os testes no dart, executar dart testes. No flutter executar flutter test

//* Suite de testes
void main() {
  final person = Person(id: 0, name: '', age: 29, height: 1.77, weight: 64.4);

  //* Group de testes
  group('isOlder', () {
    //* Teste unitário
    test('IMC shuld 20.56', () {
      expect(person.imc, 20.56);
    });

    //* Teste unitário
    test('If age higher than 18, isOlder shuld return true', () {
      expect(person.isOlder, true);
    });
  });
}
