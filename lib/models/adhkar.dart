import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;

class Adhkar {
  Adhkar({
    required this.id,
    required this.category,
    required this.array,
  });

  factory Adhkar.fromJson(Map<String, dynamic> json) {
    return Adhkar(
      id: json['id'],
      category: json['category'],
      array:
          (json['array'] as List).map((item) => Array.fromJson(item)).toList(),
    );
  }

  List<Array> array;
  String category;
  int id;
}

class Array {
  Array({
    required this.id,
    required this.text,
    required this.count,
  });

  factory Array.fromJson(Map<String, dynamic> json) {
    return Array(
      id: json['id'],
      text: json['text'],
      count: json['count'],
    );
  }

  int count;
  int id;
  String text;
}

Future<List<Adhkar>> loadAdhkars() async {
  final String jsonString =
      await rootBundle.loadString('lib/models/data/adhkar.json');
  final List<dynamic> jsonList =
      convert.jsonDecode(jsonString) as List<dynamic>;

  final List<Adhkar> adhkars =
      jsonList.map((json) => Adhkar.fromJson(json)).toList();

  return adhkars;
}
