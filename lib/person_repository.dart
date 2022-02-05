import 'dart:convert';
import 'package:http/http.dart';
import 'package:teste_unitario_um/person.dart';

class PersonRepository {
  final Client client;

  PersonRepository(this.client);

  Future<List<Person>> getPersonList() async {
    final response = await client.get(Uri.parse(''));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => Person.fromMap(e)).toList();
    } else {
      throw Exception('Error');
    }
  }
}
