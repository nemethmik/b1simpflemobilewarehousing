import 'package:b1simpflemobilewarehousing/b1simpflemobilewarehousing.dart';

abstract class IWarehousingServices with IActivities, IItems, IPurchasing {}
class WarehousingServicesImpl extends B1Services 
  with ActivitiesImpl, ItemsImpl, PurchasingImpl 
  implements IWarehousingServices {
  WarehousingServicesImpl(B1ServiceLayer sl) : super(sl);
}

final connection = B1Connection(
  serverUrl: "http://hana93srv:50001/b1s/v1/",
  userName: "manager",
  password: "123qwe",
  companyDB: "SBODEMOUS",
);
main() async {
  final IWarehousingServices b1s = WarehousingServicesImpl(B1ServiceLayer(connection));
  final List<Document> r = await b1s.queryOpenPurchaseOrdersAsync();
  print("Documents returned ${r.length}");
}
