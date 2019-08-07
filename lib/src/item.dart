// import 'dart:collection';
import 'dart:convert';
import 'package:b1serviceflayer/b1serviceflayer.dart';
import 'entitybase.dart';

class BoInventorySystem extends BoEnums {
  static final Map<String,BoInventorySystem> enums = {};
  static final bis_MovingAverage = BoInventorySystem("bis_MovingAverage");
  static final bis_Standard = BoInventorySystem("bis_Standard");
  static final bis_FIFO = BoInventorySystem("bis_FIFO");
  static final bis_SNB = BoInventorySystem("bis_SNB");
  BoInventorySystem(String value) : super(value) {enums[value] = this;}
}

class Item extends EntityBase {
  static const ItemCode = "ItemCode";
  static const ItemsGroupCode = "ItemsGroupCode";
  static const CreateDate = "CreateDate";
  static const ItemName = "ItemName";
  static const PurchaseItem = "PurchaseItem";
  static const CostAccountingMethod = "CostAccountingMethod";
  Item.fromJson(String jsonString) : super.fromJson(jsonString);
  Item.fromMap(Map<String,dynamic> jsonMap) : super.fromMap(jsonMap);
  static List<Item> fromValue(String jsonString) {
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    return List<Item>.from(jsonMap["value"].map((x) => Item.fromMap(x)));
  }  
  int get itemsGroupCode {return this[ItemsGroupCode];}
  set itemsGroupCode(int v) {this[ItemsGroupCode] = v;}
  DateTime get createDate => this[CreateDate] == null ? null : DateTime.parse(this[CreateDate]);
  set createDate(DateTime d) {this[CreateDate] = EntityBase.dateToString(d);}
  String get itemCode => this[ItemCode];
  set itemCode(String s) {this[ItemCode] = s;}
  String get itemName => this[ItemName];
  set itemName(String s) {this[ItemName] = s;}
  bool get purchaseItem => this[PurchaseItem] == BoYesNoEnum.tYES.value;
  set purchaseItem(bool b) {this[PurchaseItem] = b ? BoYesNoEnum.tYES.value : BoYesNoEnum.tNO.value;}
  BoInventorySystem get costAccountingMethod => BoInventorySystem.enums[this[CostAccountingMethod]];
  set costAccountingMethod(BoInventorySystem b) {this[CostAccountingMethod] = b.value;}
} 
