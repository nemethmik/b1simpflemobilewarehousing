import "package:meta/meta.dart";
import 'package:b1simpflemobilewarehousing/b1simpflemobilewarehousing.dart';

mixin PurchasingImpl on B1Services implements IPurchasing {  
  @override
  Future<List<Document>> queryOpenPurchaseOrdersAsync({String supplierCode,String warehouseCode}) async {
    //String purchaseOrderJSONString = await _sl.queryAsync("PurchaseOrders?\$select=DocNum,CardName&\$filter=DocumentStatus eq 'bost_Open'");
    String purchaseOrderJSONString = await sl.queryAsync("PurchaseOrders?\$filter=DocumentStatus eq 'bost_Open'");
    return Document.fromValue(purchaseOrderJSONString);
  }
  @override
  Future<Document> getPurchaseOrderAsync(int docEntry) async {
    String purchaseOrderJSONString = await sl.queryAsync("PurchaseOrders(${docEntry})");
    return Document.fromJson(purchaseOrderJSONString);
  }
}
class B1PurchasingServicesImpl extends B1Services with PurchasingImpl {
  B1PurchasingServicesImpl(B1ServiceLayer sl) : super(sl);
}
