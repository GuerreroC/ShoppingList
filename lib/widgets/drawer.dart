import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
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
          ],
        ),
      ),
    );
  }
}
