import 'package:flutter/material.dart';
import 'package:teste_unitario_um/bloc_provider.dart';
import 'package:teste_unitario_um/home_page.dart';
import 'package:teste_unitario_um/person_bloc.dart';
import 'package:teste_unitario_um/person_repository.dart';
import 'package:http/http.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        //todo Estudar injeção de dependência no dart para evitar a situação abaixo
        bloc: PersonBloc(PersonRepository(Client())),
        child: const HomePage(),
      ),
    );
  }
}
