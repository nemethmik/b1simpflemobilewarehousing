import "package:meta/meta.dart";
import 'package:b1simpflemobilewarehousing/b1simpflemobilewarehousing.dart';

mixin ItemsImpl on B1Services implements IItems {  
  @override
  Future<List<Item>> queryItemsOfGroupAsync({int itemsGroupCode}) async {
    String itemsListJSONString = await sl.queryAsync("Items?\$select=ItemCode,ItemName&\$filter=ItemsGroupCode eq ${itemsGroupCode}");
    return Item.fromValue(itemsListJSONString);
  }
}
class B1ItemsServicesImpl extends B1Services with ItemsImpl {
  B1ItemsServicesImpl(B1ServiceLayer sl) : super(sl);
}
