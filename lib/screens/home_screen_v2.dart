import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:shopping_list/providers/database_provider.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/widgets/drawer.dart';

class HomePageV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productos = ProductosProvider();
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
        backgroundColor: Colors.grey[300],
      ),
      drawer: MenuDrawer(),
      drawerEdgeDragWidth: 40,
      body: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              height: size.height * 0.7,
              child: Center(
                child: _swiper(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan[800],
                    elevation: 5,
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
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/carro_vacio.png',
                          color: Colors.white70,
                          height: 30,
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    _crearLista(context);
                    Navigator.pushNamed(context, 'newList', arguments: false);
                  }),
            )
          ],
        ),
      ),
    );
  }

  _swiper(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: _screenSize.height * 0.6,
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemCount: 3,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.79,
        itemHeight: _screenSize.height * 0.79,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  color: Colors.grey[400],
                  child: Image.asset(
                    'assets/carro_vacio.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _crearLista(BuildContext context) {
    final listaProvider = ProductosProvider();
    Map<String, Object> mandado = {};
    //Then obtienes la info de un Futuro por medio de value
    listaProvider.cargarProductosRAW(context).then(
      (value) {
        // mandado = value;
        // print(value);
        value.forEach((key, product) {
          if (key is String) {
            // mandado = product;
            // mandado['precio'] = mandado['precio'].toString();
            // print(mandado);
            // await Future.delayed(Duration(seconds: 1));
            // await DBProvider.db.newList(mandado);
            Map p = product;
            p.forEach((k, v) {
              mandado = v;
              mandado['categoria'] = key;
              // print(mandado);
              DBProvider.db.newList(mandado);
            });
          }
        });
        print('DB updated');
      },
    );
  }

  // setNewList(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Container(
  //           height: size.height * 0.8,
  //           color: Colors.red,
  //         ),
  //       );
  //     },
  //   );
  // }
}
