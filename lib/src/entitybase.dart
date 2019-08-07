import 'dart:collection';
import 'dart:convert';
import 'package:b1serviceflayer/b1serviceflayer.dart';

abstract class EntityBase extends MapBase<String,dynamic> {
  final Map<String,dynamic> _fields;
  final Map<String,dynamic> dirty = {};
  // EntityBase.fromJson(String jsonString) : _fields = json.decode(jsonString) {
  //   _fields.removeWhere((k,v)=>v==null || (v is String && v.isEmpty));
  // }
  EntityBase() : _fields = {};
  EntityBase.fromJson(String jsonString) : this.fromMap(json.decode(jsonString));
  EntityBase.fromMap(Map<String,dynamic> fields) : _fields = fields {
    _fields.removeWhere((k,v)=>v==null || (v is String && v.isEmpty));
  }
  // Unfortunately, T.fromMap is not supported by Dart, that is you cannot call
  // a named constructor of parametrized type defined for a generic function. 
  // static List<T> fromValue<T extends EntityBase>(String jsonString) {
  //   Map<String,dynamic> jsonMap = json.decode(jsonString);
  //   return List<T>.from(jsonMap["value"].map((x) => T.fromMap(x)));
  // }  
  /// Don't remove the null values here, since then the user couldn't update a non null value to null. 
  /// When the record is read, null values are deleted from the map, that's OK. 
  String toJson() {
    //This is really tricky programming inspired by Java Script's IIFE
    //return json.encode((Map<String, dynamic> m){m.removeWhere((k,v) => v == null);return m;}(this));
    return json.encode(this);
  }
  Map<String,dynamic> updatedFields() {
    return dirty.map((k,v){return MapEntry<String,dynamic>(k,_fields[k]);});
  }
  String toUpdateJson() {return /*dirty.isEmpty ? null : */json.encode(updatedFields());}
  dynamic originalValue(String field) {
    if(dirty.containsKey(field)) {return dirty[field];}
    else {return _fields[field];}
  }
  bool isDirty(String field) {return dirty.containsKey(field) && dirty[field] != _fields[field];}
  @override operator [](Object key) {return _fields[key];}
  @override void operator []=(String key, value) {
    if(_fields[key] != value) {
      if(dirty.containsKey(key)) {
        //if(dirty[key] == value) {dirty.remove(key);} 
      } else {dirty[key] = _fields[key];}
      _fields[key] = value;
    }
  }
  @override void clear() {_fields.clear();dirty.clear();}
  @override Iterable<String> get keys => _fields.keys;
  @override remove(Object key) {return _fields.remove(key);}
  ///Returns null, if date is null
  static String dateToString(DateTime d) => (d == null ? null : "${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}");
  static DateTime dateParse(String d) => (d == null ? null : DateTime.parse(d));
  static bool isYes(String y) => y == BoYesNoEnum.tYES.value;
  static String yesNo(bool y) =>  y ? BoYesNoEnum.tYES.value : BoYesNoEnum.tNO.value;
  static String enumValue(BoEnums e) => e == null ? null : e.value;
}
