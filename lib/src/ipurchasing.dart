import 'document.dart';
abstract class IPurchasing {//Goods Receipts, Suppliers
  Future<List<Document>> queryOpenPurchaseOrdersAsync({String supplierCode,String warehouseCode});
  Future<Document> getPurchaseOrderAsync(int docEntry);
}
