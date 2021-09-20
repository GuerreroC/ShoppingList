import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Mi lista del super',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white),
      drawer: MenuDrawer(),
      drawerEdgeDragWidth: 40,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              height: size.height * 0.6,
              child: Center(
                child: _homeAnimation(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(51, 84, 115, 1),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Crear nueva lista',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/carro_vacio.png',
                          color: Colors.white,
                          height: 30,
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    // _crearLista(context);
                    Navigator.pushNamed(context, 'newList', arguments: false);
                  }),
            ),
            // SizedBox(
            //   height: 20,
            // )
          ],
        ),
      ),
    );
  }

  _homeAnimation(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        height: _screenSize.height * 0.6,
        padding: EdgeInsets.only(top: 10.0),
        child: Image.asset("assets/splash.gif"));
  }
}
