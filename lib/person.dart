import 'dart:convert';
import 'dart:math' as math;

class Person {
  final int id;
  final String name;
  final int age;
  final double height;
  final double weight;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
  });

  double get imc {
    var result = weight / math.pow(height, 2);
    return double.parse(result.toStringAsFixed(2));
  }

  bool get isOlder {
    return age >= 18;
  }

  Person copyWith({
    int? id,
    String? name,
    int? age,
    double? height,
    double? weight,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: int.parse(map['id'] ?? 0),
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      height: map['height']?.toDouble() ?? 0.0,
      weight: map['weight']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(id: $id, name: $name, age: $age, height: $height, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.id == id &&
        other.name == name &&
        other.age == age &&
        other.height == height &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        height.hashCode ^
        weight.hashCode;
  }
}
