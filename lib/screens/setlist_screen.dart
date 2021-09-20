import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list/models/list_model.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/providers/database_provider.dart';

class SetListPage extends StatefulWidget {
  @override
  _SetListPageState createState() => _SetListPageState();
}

class _SetListPageState extends State<SetListPage> {
  List<bool> _checkboxs = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listaProvider = ProductosProvider();
    List<ListaMandado> _listaProductos =
        ModalRoute.of(context).settings.arguments;
    for (int value = 0; value < _listaProductos.length; value++) {
      // print(_listado[i].nombre);
      if (_checkboxs.length < _listaProductos.length) {
        _checkboxs.add(false);
      }
    }
    _removeDuplicates();
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return false; // true: habilita appbar back
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.055),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.grey[200]),
            centerTitle: true,
            title: Text(
              'Escoge tus productos',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.grey[200],
          ),
        ),
        // drawer: MenuDrawer(),
        // drawerEdgeDragWidth: 40,
        body: Container(
          height: size.height * 0.79,
          alignment: Alignment.center,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              height: size.height * 0.79,
              child: _savedList(_listaProductos, size, listaProvider),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.12,
          color: Colors.grey[200],
          // color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _removeDuplicates();
                    categoriaLista[_listaProductos.first.categoria] = true;
                    isSelected[_listaProductos.first.categoria] = _checkboxs;
                    // print(categoriaLista);
                    // _listaProductos.forEach((element) {
                    //       if (element.nombre == _listaProductos[i].nombre) {
                    //         element.basics = 1;
                    //         selectedProducts.add(element);
                    //         print(selectedProducts.last.basics);
                    //       }
                    //     });
                    //     listaGlobal.add(_listaProductos[i]);
                    Navigator.pushNamed(context, 'newList', arguments: false);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Color.fromRGBO(51, 84, 115, 1),
                      height: 60,
                      width: size.width * 0.42,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Añadir artículos de otra categoria',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _removeDuplicates();
                    selectedProducts.forEach((element) {
                      // print(element.nombre);
                    });
                    Navigator.pushReplacementNamed(context, 'list');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Color.fromRGBO(51, 84, 115, 1),
                      height: 60,
                      width: size.width * 0.42,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Artículos: ${listaGlobal.length}',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.white70),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                isUpdate
                                    ? Text(
                                        'Actualizar Lista',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'Crear Lista',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold),
                                      ),
                                Icon(
                                  Icons.check,
                                  color: Colors.white70,
                                  size: 25,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

/*
  ListView _newList(List<ListaMandado> _listaProductos, Size size,
      ProductosProvider listaProvider) {
    // print(selectedProducts);
    categoriaLista[_listaProductos.first.categoria] = true;
    _listaProductos.forEach(
      (element) {
        if (element.basics == 1) {
          selectedProducts.add(element);
          listaGlobal.add(element);
        }
      },
    );
    return ListView.builder(
        itemBuilder: (context, i) {
          if (_listaProductos[i].basics == 1) {
            _checkboxs[i] = true;
          }
          // print(_listaProductos[i].basics);
          // print(checkboxs[i]);
          // print(_listaProductos[i].basics);
          // final cat = DBProvider.db
          //     .getProductsById(_listaProductos[i].id)
          //     .then((value) => value.basics);
          return Container(
            height: 40,
            // child: Text('${_listaProductos[i].nombre}'),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Image.asset(
                            'assets/${listaProvider.categorias['${_listaProductos[i].categoria}']}.png',
                            height: 30),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Container(
                        child: Text(
                          _listaProductos[i].nombre,
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: size.width * 0.425,
                      ),
                      // Text(lista[i].id.toString()),
                      // Text(lista[i].basics.toString()),
                      (_listaProductos[i].precio.toString() == '0.0')
                          ? Container(
                              width: size.width * 0.15,
                              height: 30,
                              child: Text('-'),
                              alignment: Alignment.centerRight,
                            )
                          : Container(
                              alignment: Alignment.centerRight,
                              width: size.width * 0.15,
                              height: 30,
                              child: Text(
                                  '\$ ${_listaProductos[i].precio.toString()}'),
                            )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(
                      () {
                        print(_listaProductos[i].nombre);
                        selectedProducts.add(_listaProductos[i]);
                        _checkboxs[i] = !_checkboxs[i];
                        // print(selectedProducts.last.nombre);
                        print(_checkboxs);
                      },
                    );
                  },
                  child: Container(
                    width: size.width * 0.1,
                    height: 30,
                    // child: Icon(
                    //   FontAwesomeIcons.chevronRight,
                    //   size: 20,
                    //   color: Colors.black54,
                    // ),
                    child: (_checkboxs[i])
                        ? Icon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.green,
                          )
                        : (_checkboxs[i])
                            ? Icon(
                                FontAwesomeIcons.checkCircle,
                                color: Colors.green,
                              )
                            : Icon(
                                FontAwesomeIcons.circle,
                                color: Colors.green,
                              ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: _listaProductos.length);
  }
*/
  ListView _savedList(List<ListaMandado> _listaProductos, Size size,
      ProductosProvider listaProvider) {
    if (categoriaLista[_listaProductos.first.categoria] == false) {
      _listaProductos.forEach(
        (element) {
          if (element.basics == 1) {
            selectedProducts.add(element);
            listaGlobal.add(element);
          }
        },
      );
    }
    return ListView.builder(
        itemBuilder: (context, i) {
          // if (selectedProducts.contains(_listaProductos[i])) {
          //   final res = _listaProductos[i].nombre;
          //   print(res);
          // }
          if (_listaProductos[i].basics == 1 &&
              categoriaLista[_listaProductos.first.categoria] == false) {
            _checkboxs[i] = true;
          }
          if (categoriaLista[_listaProductos.first.categoria]) {
            _checkboxs = isSelected[_listaProductos.first.categoria];
            return _sameCategory(size, listaProvider, _listaProductos, i);
          } else {
            // categoriaLista[_listaProductos.first.categoria] = true;
            // print(categoriaLista);
            return _otherCategory(size, listaProvider, _listaProductos, i);
          }
        },
        itemCount: _listaProductos.length);
  }

  Container _sameCategory(Size size, ProductosProvider listaProvider,
      List<ListaMandado> _listaProductos, int i) {
    // print('segunda visita en adelante');
    // final List<ListaMandado> _listado = [];
    // selectedProducts.forEach((element) {
    //   if (element.basics == 1 &&
    //       element.categoria == _listaProductos.first.categoria) {
    //     _listado.add(element);
    //   }
    // });
    // _listaProductos.forEach((element) {
    //   if (element.basics == 0) {
    //     _listado.add(element);
    //   }
    // });
    return Container(
      height: 40,
      child: Row(
        children: [
          Container(
            width: size.width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                      'assets/${listaProvider.categorias['${_listaProductos[i].categoria}']}.png',
                      height: 30),
                ),
                SizedBox(width: size.width * 0.05),
                Container(
                  child: Text(
                    _listaProductos[i].nombre,
                    overflow: TextOverflow.ellipsis,
                  ),
                  width: size.width * 0.425,
                ),
                // Text(lista[i].id.toString()),
                // Text(lista[i].basics.toString()),
                (_listaProductos[i].precio.toString() == '0.0')
                    ? Container(
                        width: size.width * 0.15,
                        height: 30,
                        child: Text('-'),
                        alignment: Alignment.centerRight,
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        width: size.width * 0.15,
                        height: 30,
                        child:
                            Text('\$ ${_listaProductos[i].precio.toString()}'),
                      )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(
                () {
                  _checkboxs[i] = !_checkboxs[i];
                  selectedProducts.add(_listaProductos[i]);
                  if (_checkboxs[i]) {
                    listaGlobal.add(_listaProductos[i]);
                  } else {
                    listaGlobal.remove(_listaProductos[i]);
                  }
                  print(_listaProductos[i].nombre);
                },
              );
            },
            child: Container(
              width: size.width * 0.1,
              height: 30,
              // child: Icon(
              //   FontAwesomeIcons.chevronRight,
              //   size: 20,
              //   color: Colors.black54,
              // ),
              child: (_checkboxs[i])
                  ? Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                    )
                  : (_checkboxs[i])
                      ? Icon(
                          FontAwesomeIcons.checkCircle,
                          color: Colors.green,
                        )
                      : Icon(
                          FontAwesomeIcons.circle,
                          color: Colors.green,
                        ),
            ),
          )
        ],
      ),
    );
  }

  Container _otherCategory(Size size, ProductosProvider listaProvider,
      List<ListaMandado> _listaProductos, int i) {
    // print('Primera visita');
    // print(_checkboxs);
    return Container(
      height: 40,
      // child: Text('${_listaProductos[i].nombre}'),
      child: Row(
        children: [
          Container(
            width: size.width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                      'assets/${listaProvider.categorias['${_listaProductos[i].categoria}']}.png',
                      height: 30),
                ),
                SizedBox(width: size.width * 0.05),
                Container(
                  child: Text(
                    _listaProductos[i].nombre,
                    overflow: TextOverflow.ellipsis,
                  ),
                  width: size.width * 0.425,
                ),
                // Text(lista[i].id.toString()),
                // Text(lista[i].basics.toString()),
                (_listaProductos[i].precio.toString() == '0.0')
                    ? Container(
                        width: size.width * 0.15,
                        height: 30,
                        child: Text('-'),
                        alignment: Alignment.centerRight,
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        width: size.width * 0.15,
                        height: 30,
                        child:
                            Text('\$ ${_listaProductos[i].precio.toString()}'),
                      )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(
                () {
                  _checkboxs[i] = !_checkboxs[i];
                  selectedProducts.add(_listaProductos[i]);
                  categoriaLista[_listaProductos.first.categoria] = true;
                  isSelected[_listaProductos.first.categoria] = _checkboxs;
                  if (_checkboxs[i]) {
                    listaGlobal.add(_listaProductos[i]);
                  } else {
                    listaGlobal.remove(_listaProductos[i]);
                  }
                  print(_listaProductos[i].nombre);
                  // print(isSelected);
                },
              );
            },
            child: Container(
              width: size.width * 0.1,
              height: 30,
              // child: Icon(
              //   FontAwesomeIcons.chevronRight,
              //   size: 20,
              //   color: Colors.black54,
              // ),
              child: (_checkboxs[i])
                  ? Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                    )
                  : (_checkboxs[i])
                      ? Icon(
                          FontAwesomeIcons.checkCircle,
                          color: Colors.green,
                        )
                      : Icon(
                          FontAwesomeIcons.circle,
                          color: Colors.green,
                        ),
            ),
          )
        ],
      ),
    );
  }

  _removeDuplicates() {
    listaGlobal = listaGlobal.toSet().toList();
    // print(listaGlobal);
    /*
    // convert each item to a string by using JSON encoding
    final jsonList = listaGlobal.map((item) => jsonEncode(item)).toList();

    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();

    // convert each item back to the original form using JSON decoding
    final result =
        uniqueJsonList.map((item) => jsonDecode(item)).toList();

    // listaGlobal = result;
    */
  }
}
