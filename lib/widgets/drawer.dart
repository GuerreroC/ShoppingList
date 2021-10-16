import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/providers/database_provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      color: Colors.red,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                height: 200,
                width: 200,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 200,
                  height: 200,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              minLeadingWidth: 10,
              leading: Icon(
                FontAwesomeIcons.cartPlus,
                color: Colors.green,
              ),
              title: Text('Añadir producto nuevo'),
              onTap: () {
                _listUpdate(context);
                Navigator.pushNamed(context, 'newProduct');
              },
            ),
            SizedBox(height: 10),
            ListTile(
              minLeadingWidth: 10,
              leading: Icon(
                FontAwesomeIcons.cartArrowDown,
                color: Colors.green,
              ),
              title: Text('Mis Listas Creadas'),
              onTap: () {
                Navigator.pushNamed(context, 'list');
              },
            ),
            SizedBox(height: size.height * 0.4),
            ListTile(
              minLeadingWidth: 10,
              leading: Icon(
                FontAwesomeIcons.database,
                color: Colors.green,
              ),
              title: Text('Database Reset'),
              onTap: () {
                DBProvider.db.deleteAllScans();
                Navigator.pushNamed(context, 'home');
              },
            ),
          ],
        ),
      ),
    );
  }

  _listUpdate(BuildContext context) {
    final listaProvider = ProductosProvider();
    Map<String, Object> mandado = {};
    //Then obtienes la info de un Futuro por medio de value
    listaProvider.cargarProductosRAW(context).then(
      (value) {
        // mandado = value;
        // print(value);
        value.forEach((key, product) {
          if (key is String) {
            Map p = product;
            p.forEach((k, v) {
              mandado = v;
              mandado['categoria'] = key;
              DBProvider.db.newList(mandado);
            });
          }
        });
        print('DB updated');
      },
    );
  }
}
