import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/providers/database_provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<bool> checkboxs = [];
  int enCarrito = 0;
  double amount = 0.0;
  double _total = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _listaProvider = new ProductosProvider();
    for (int value = 0; value < listaGlobal.length; value++) {
      if (checkboxs.length < listaGlobal.length) {
        checkboxs.add(false);
      }
    }
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return false; // true: habilita appbar back
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey[300]),
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
          actions: [
            IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'newList', arguments: true);
                })
          ],
          actionsIconTheme: IconThemeData(color: Colors.black),
        ),
        // drawer: MenuDrawer(),
        // drawerEdgeDragWidth: 40,
        body: Container(
          height: size.height * 0.79,
          alignment: Alignment.center,
          color: Colors.grey[300],
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              height: size.height * 0.79,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: listaGlobal.length,
                itemBuilder: (context, i) {
                  // bool selected = false;
                  // print(lista[i].nombre);
                  // return _crearItem(context, productos[i], productosBloc);
                  return Container(
                    // color: Colors.red,
                    height: 40,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Row(
                      children: [
                        Container(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                  'assets/${_listaProvider.categorias['${listaGlobal[i].categoria}']}.png',
                                  height: 30),
                              SizedBox(width: size.width * 0.04),
                              Container(
                                child: Text(
                                  listaGlobal[i].nombre,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                width: size.width * 0.45,
                              ),
                              (listaGlobal[i].precio.toString() == '0.0')
                                  ? Container(
                                      width: size.width * 0.2,
                                      height: 30,
                                      child: Text('-'),
                                      alignment: Alignment.centerRight,
                                    )
                                  : Container(
                                      alignment: Alignment.centerRight,
                                      width: size.width * 0.2,
                                      height: 30,
                                      child: Text(
                                          '\$ ${listaGlobal[i].precio.toStringAsFixed(2)}'),
                                    )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            isUpdate
                                ? _addPrice(context, i, true)
                                : _addPrice(context, i, false);
                          },
                          child: Container(
                            width: size.width * 0.1,
                            height: 30,
                            // child: Icon(
                            //   FontAwesomeIcons.chevronRight,
                            //   size: 20,
                            //   color: Colors.black54,
                            // ),
                            child: (checkboxs[i])
                                ? Icon(
                                    FontAwesomeIcons.checkCircle,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    FontAwesomeIcons.circle,
                                    color: Colors.grey,
                                  ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.cyan[800],
          height: size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.15,
                height: size.height * 0.085,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/carro_lleno.png',
                      color: Colors.white54,
                      scale: 8,
                    ),
                    Positioned(
                      width: size.width * 0.06,
                      right: size.width * 0,
                      top: size.width * 0,
                      // child: Icon(
                      //   Icons.circle,
                      //   color: Colors.red,
                      //   size: 30,
                      // ),
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$enCarrito',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                  Text(
                    '\$ ${_total.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white54, fontSize: 25),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  isUpdate = false;
                  listaGlobal = [];
                  selectedProducts = [];
                  isSelected = {};
                  Navigator.pushNamed(context, 'home');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finalizar',
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.white54,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addPrice(BuildContext context, int i, bool isAdded) {
    double precio = 0;
    return checkboxs[i]
        ? showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('¿Remover del carrito?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      if (checkboxs[i]) {
                        checkboxs[i] = false;
                        enCarrito--;
                        _total = _total - listaGlobal[i].precio;
                        listaGlobal[i].precio = 0.0;
                      } else {
                        checkboxs[i] = !checkboxs[i];
                        enCarrito++;
                      }

                      // print(checkboxs[i]);
                      Navigator.of(context).pop(true);
                      setState(() {});
                    },
                    child: Text('Sí'))
              ],
            ),
            barrierDismissible: false, //false hace que no se pueda quitar
          )
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('¿Añadir al carrito?'),
              content: TextFormField(
                enableSuggestions: false,
                autofocus: true,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(25.0),
                  //   borderSide: BorderSide(
                  //     color: Colors.black54,
                  //     width: 4.0,
                  //   ),
                  // ),
                  // hintText: 'Nombre',
                  labelText: 'Añade el precio del articulo',
                  labelStyle: TextStyle(color: Colors.blue[900], fontSize: 18),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(25),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(25.0),
                  //   borderSide: BorderSide(
                  //       color: Colors.blue[900], width: 4.0),
                  // ),
                ),
                cursorColor: Colors.blue[900],
                onChanged: (value) => precio = double.parse(value),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        if (checkboxs[i]) {
                          checkboxs[i] = false;
                          enCarrito--;
                        } else {
                          checkboxs[i] = !checkboxs[i];
                          enCarrito++;
                        }
                        listaGlobal[i].precio = precio;
                        _total = _total + precio;
                        Navigator.of(context).pop(true);
                      });
                    },
                    child: Text('OK'))
              ],
            ),
            barrierDismissible: false, //false hace que no se pueda quitar
          );
  }
}
