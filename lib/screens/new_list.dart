import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list/models/list_model.dart';
import 'package:shopping_list/providers/database_provider.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/widgets/categoria.dart';

class NewListPage extends StatelessWidget {
  const NewListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool editList = ModalRoute.of(context).settings.arguments;
    if (editList == true) {
      isUpdate = true;
    }
    final producto = ProductosProvider();
    final _producto = producto.categorias;
    final size = MediaQuery.of(context).size;
    _crearLista(context);
    return Scaffold(
      appBar: AppBar(
        title: (editList)
            ? Text(
                'Añade mas articulos',
                style: TextStyle(color: Colors.black),
              )
            : Text(
                'Escoge una categoria',
                style: TextStyle(color: Colors.black),
              ),
        actions: (editList)
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.cartPlus,
                      size: 30,
                      color: Color.fromRGBO(181, 196, 196, 1.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'newItem');
                    },
                  ),
                )
              ]
            : [],
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.79,
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Categoria(
                                '${_producto['Frutas y Verduras']}.png',
                                'Frutas y Verduras'),
                            onTap: () {
                              _getProductos(context, 'Frutas y Verduras');
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Frutas y Verduras');
                            },
                          ),
                          GestureDetector(
                            child: Categoria(
                                '${_producto['Abarrotes']}.png', 'Abarrotes'),
                            onTap: () {
                              _getProductos(context, 'Abarrotes');
                              // DBProvider.db.newList(mandado);
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Abarrotes');
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Categoria('${_producto['Carnes Frias']}.png',
                                'Carnes Frias'),
                            onTap: () {
                              _getProductos(context, 'Carnes Frias');
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Carnes Frias');
                            },
                          ),
                          GestureDetector(
                            child: Categoria(
                                '${_producto['Aseo Personal']}.png',
                                'Aseo Personal'),
                            onTap: () {
                              _getProductos(context, 'Aseo Personal');
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Aseo Personal');
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Categoria(
                                '${_producto['Cocina']}.png', 'Cocina'),
                            onTap: () {
                              _getProductos(context, 'Cocina');
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Cocina');
                            },
                          ),
                          GestureDetector(
                            child:
                                Categoria('${_producto['Baño']}.png', 'Baño'),
                            onTap: () {
                              _getProductos(context, 'Baño');
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Baño');
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child:
                                Categoria('${_producto['Hogar']}.png', 'Hogar'),
                            onTap: () {
                              _getProductos(context, 'Hogar');
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Hogar');
                            },
                          ),
                          GestureDetector(
                            child:
                                Categoria('${_producto['Otros']}.png', 'Otro'),
                            onTap: () {
                              _getProductos(context, 'Otros');
                              // Navigator.pushNamed(context, 'list',
                              //     arguments: 'Otros');
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            (listaGlobal.isEmpty)
                ? Container(
                    height: size.height * 0.1,
                    color: Colors.grey[100],
                    width: double.infinity,
                  )
                : Container(
                    height: size.height * 0.1,
                    color: Colors.grey[100],
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(51, 84, 115, 1),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Artículos: ${listaGlobal.length}',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                    (editList)
                                        ? Text(
                                            'Actualizar lista',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            'Crear nueva lista',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  'assets/carro_vacio.png',
                                  color: Colors.white,
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'list');
                          }),
                    ),
                  ),
          ],
        ),
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
        // print(mandado);
        print('DB updated');
      },
    );
  }

  _getProductos(BuildContext context, String categoria) async {
    List<ListaMandado> list =
        await DBProvider.db.getProductsByCategory(categoria);
    Navigator.pushNamed(context, 'setList', arguments: list);
  }
}
