This [b1simpflemobilewarehousing](https://pub.dev/packages/b1simpflemobilewarehousing) 
is a library for Flutter/Dart developers that provides a nice collection of business logic classes and functions on top of [SAP BusinessOne](https://www.sap.com/products/business-one.html) (B1) Service Layer (SL) for mobile warehousing applications written in Flutter/Dart. 

This library based on top of the package [b1serviceflayer](https://pub.dev/packages/b1serviceflayer), which is generic API to use B1 SL. If you are interested what is B1 and SL read the documentation of this package.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

SAP, SAP Business One are registered trademarks of [SAP](https://www.sap.com/corporate/en/company.html)  

## Usage

The library is composed a number of business logic intercases, mixins and concrete classes composed from these mixins.
The intercases are abstract classes with the prefix I; each of them defines a functionality group, which are called modules. Their primary goal is to provide a consistent contract between the UI, application layers and the business logic.
- IActivities
- IItems
- IPurchasing

Each of these interfaces has mixin implementation, each of them defined with the `on B1Services`, shich requires a B1ServiceLayer from the package b1serciceflayer. 
- ActivitiesImpl
- ItemsImpl
- PurchasingImpl

Each of them has an abstract class version extending B1services:
- B1ItemsServicesImpl
- B1ActivitiesServicesImpl
- B1PurchasingServicesImpl

In the example below an IWarehousingServices interface is defined combining all the module interfaces. Then, the class WarehousingServicesimpl uses the mixins to implement all interfaces.
It is a common practice in well architected applications, that the business logic object is defined with an interface type.

```dart
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
  password: "manager",
  companyDB: "SBODEMOUS",
);
main() async {
  final IWarehousingServices b1s = WarehousingServicesImpl(B1ServiceLayer(connection));
  final List<Document> r = await b1s.queryOpenPurchaseOrdersAsync();
  print("Documents returned ${r.length}");
}
```

A number of utility classes have been defined for easy handling of the entities. Activity, Document and Item all are derived from the abstract EntityBase, which is implemented on a MapBase class. These objects are actually dynamic maps, which gives a number of advantages. 
When an JSON string is returned, the library first decodes it to a Map<String,dynamic>
or a List<Map<String,dynamic>> and the null values are removed automatically; this, reduces significantly the size of these maps.
These classes provide observability, as well as dirty monitoring.

All the typed fields are simple getters and setters supporting String, int, DateTime, double, bool and enumeration data types.
Enumeration types are defined with const classes based on the class BoEnums from b1serviceflayer.

The package today is far from complete. When it has a version number 1.0.0, then it could be regarded as complete with at least one Flutter application behind it.

## License
The license is an open source BSD license as suggested by the [Dart package publishing documentation](https://dart.dev/tools/pub/publishing), since Dart itself has BSD license. 

See the [LICENSE.md](https://github.com/nemethmik/b1simpflemobilewarehousing/blob/master/LICENSE.md) file.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/nemethmik/b1simpflemobilewarehousing
