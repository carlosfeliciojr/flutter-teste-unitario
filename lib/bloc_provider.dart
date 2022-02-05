import 'package:flutter/widgets.dart';
import 'package:teste_unitario_um/person_bloc.dart';

//* Classe para injeção de dependencia dp bloc nos widgets e mocks

class BlocProvider extends InheritedWidget {
  final PersonBloc bloc;

  const BlocProvider({
    Key? key,
    required this.bloc,
    required Widget child,
  }) : super(key: key, child: child);

  static PersonBloc get(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider>();

    if (provider != null) {
      return provider.bloc;
    } else {
      throw Exception("Bloc not found");
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // Verifica se o widget anterior é diferente do novo widget
    return (oldWidget as BlocProvider).bloc.state != bloc.state;
  }
}
