import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:shopping_list/screens/list_screen.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/screens/new_list.dart';
import 'package:shopping_list/screens/new_product.dart';
import 'package:shopping_list/screens/product_details.dart';
import 'package:shopping_list/screens/setlist_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShoppingList',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'list': (BuildContext context) => ListPage(),
        'newProduct': (BuildContext context) => NewProductPage(),
        'newList': (BuildContext context) => NewListPage(),
        'productDetails': (BuildContext context) => ProductDetailsPage(),
        'setList': (BuildContext context) => SetListPage(),
        'newItem': (BuildContext context) => NewItemPage()
      },
    );
  }
}
