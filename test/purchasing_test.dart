import 'package:test/test.dart';
import 'package:b1simpflemobilewarehousing/b1simpflemobilewarehousing.dart';
import 'defaultconnection.dart' as conf;
void main() {
  group("B1SL_QueryTestSeries", () {
    final IPurchasing b1s = B1PurchasingServicesImpl(B1ServiceLayer(conf.connection));
    test("QueryOpenPurchaseOrdersAll", () async {
      final queryResponse = await b1s.queryOpenPurchaseOrdersAsync(supplierCode: "",warehouseCode: "");
      expect(queryResponse[0].docNum,isNotNull);
      print("Number of purchase orders ${queryResponse.length}");
    });
  });
}