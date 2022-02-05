import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'package:teste_unitario_um/person_repository.dart';

class ClientMock extends Mock implements Client {}

const jsonReturn =
    '[{"id": "1","name": "Fulano de Tal","age": 20, "height": 1.75, "weight": 70},{"id": "1","name": "Fulano de Tal","age": 20, "height": 1.75, "weight": 70},{"id": "1","name": "Fulano de Tal","age": 20, "height": 1.75, "weight": 70}]';

void main() {
  setUp(() {
    print("Inicia o teste");
  });

  tearDown(() {
    print("Destrói o teste");
  });

  setUpAll(() {
    print("Inicia o suite");
  });

  tearDownAll(() {
    print("Destroi o suite");
  });

  final client = ClientMock();
  final repository = PersonRepository(client);

  group('Connection Test', () {
    test('Shuld get person list', () async {
      when(() => client.get(Uri.parse('')))
          .thenAnswer((_) async => Response(jsonReturn, 200));

      final list = await repository.getPersonList();

      expect(list.isNotEmpty, equals(true));
      expect(list.first.name, equals('Fulano de Tal'));
    });

    test('Shuld return an error', () async {
      when(() => client.get(Uri.parse('')))
          .thenAnswer((_) async => Response(jsonReturn, 404));

      expect(() async => await repository.getPersonList(), throwsException);
    });
  });
}
