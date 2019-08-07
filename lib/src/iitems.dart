import 'package:b1simpflemobilewarehousing/b1simpflemobilewarehousing.dart';

abstract class IItems {//Goods Receipts, Suppliers
  Future<List<Item>> queryItemsOfGroupAsync({int itemsGroupCode});
}