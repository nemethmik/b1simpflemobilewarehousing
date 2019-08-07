import 'dart:convert';
import 'package:b1serviceflayer/b1serviceflayer.dart';
import 'entitybase.dart';

class Document extends EntityBase {
  static const DocNum = "DocNum";
  Document.fromJson(String jsonString) : super.fromJson(jsonString);
  Document.fromMap(Map<String,dynamic> jsonMap) : super.fromMap(jsonMap);
  static List<Document> fromValue(String jsonString) {
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    return List<Document>.from(jsonMap["value"].map((x) => Document.fromMap(x)));
  }
  int get docNum => this[DocNum];
  set docNUm(int v) => this[DocNum] = v;
}