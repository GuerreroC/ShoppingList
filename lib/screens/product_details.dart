import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_model.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/providers/database_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key key}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final formKey = GlobalKey<FormState>();
  final createArticle = ProductosProvider();
  ListaMandado producto = ListaMandado();
  int _basicsValue = 0;
  String _nameValue = '';
  double _precioValue = 0;
  bool _precioEnabled = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String _categoria =
        ModalRoute.of(context).settings.arguments.toString();
    // print(createArticle.categorias[_categoria]);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Detalles del Articulo',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        height: size.height * 0.9,
        color: Colors.grey[300],
        child: Stack(
          // fit: StackFit.passthrough,
          // alignment: AlignmentDirectional.center,
          children: [
            Container(
              // height: size.height * 0.88,
              width: double.infinity,
              color: Colors.grey[300],
              padding: EdgeInsets.all(15),
              child: _imagen(context, _categoria),
            ),
            SingleChildScrollView(
              reverse: true,
              physics: ClampingScrollPhysics(),
              child: Container(
                // height: size.height * 0.4,
                width: double.infinity,
                // color: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 400,
                      ),
                      Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _nombre(),
                            SizedBox(height: 20),
                            _precio(_precioEnabled),
                            SizedBox(height: 10),
                            _basicsSwitch(_basicsValue),
                            _precioSwitch(_precioEnabled),
                            _addButtom(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imagen(BuildContext context, Object categoria) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.08),
                Image.asset(
                  'assets/${createArticle.categorias[categoria]}.png',
                  color: Colors.black54,
                  width: size.width * 0.6,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nombre() {
    return TextFormField(
      autofocus: true,
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.black54,
            width: 4.0,
          ),
        ),
        // hintText: 'Nombre',
        labelText: 'Nombre',
        labelStyle: TextStyle(color: Colors.blue[800], fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.lightGreen[700], width: 4.0),
        ),
      ),
      cursorColor: Colors.green,
      onFieldSubmitted: (value) {
        setState(() {
          _nameValue = value;
        });
      },
      onSaved: (value) {
        setState(() {
          _nameValue = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _nameValue = value;
        });
      },
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del Articulo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _basicsSwitch(int basics) {
    return SwitchListTile(
        value: (basics == 1) ? true : false,
        title: Text('Agregar a Favoritos'),
        activeColor: Colors.indigo,
        onChanged: (value) {
          setState(() {
            basics = value ? 1 : 0;
            _basicsValue = basics;
          });
        });
  }

  Widget _precioSwitch(bool _precioEnable) {
    return SwitchListTile(
        value: _precioEnable,
        title: Text('Agregar Precio'),
        activeColor: Colors.indigo,
        onChanged: (value) {
          setState(() {
            _precioEnable = value;
            _precioEnabled = _precioEnable;
          });
        });
  }

  Widget _precio(bool precio) {
    if (precio == false) {
      return SizedBox(height: 60);
    } else
      return TextFormField(
        autofocus: true,
        enabled: precio,
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: false),
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.black54,
              width: 4.0,
            ),
          ),
          // hintText: 'Nombre',
          labelText: 'Precio',
          labelStyle: TextStyle(color: Colors.blue[800], fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.lightGreen[700], width: 4.0),
          ),
        ),
        cursorColor: Colors.green,
        onChanged: (value) => _precioValue = double.parse(value),
      );
  }

  _addButtom() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: _submit,
        child: Container(
          width: size.width * 0.8,
          height: 50,
          child: Center(
            child: Text(
              'Guardar Articulo',
              style: TextStyle(
                color: Colors.grey[200],
              ),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }

  void _submit() async {
    final String _categoria =
        ModalRoute.of(context).settings.arguments.toString();

    // if (!formKey.currentState.validate()) return;
    // formKey.currentState.save();

    setState(() {
      FocusScope.of(context).unfocus();
      DBProvider.db.getListLenght().then((value) {
        producto.nombre = _nameValue;
        producto.basics = _basicsValue;
        producto.precio = _precioValue;
        producto.id = value + 1;
        createArticle.crearProducto(producto, _categoria);
      });
      mostrarSnackBar('¡Guardado!');

      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false)
          .then((value) => setState(() {}));
    });
  }

  void mostrarSnackBar(String mensaje) {
    final snackBar = SnackBar(
      // behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      content: Container(
        alignment: Alignment.bottomCenter,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.done_sharp,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
      ),
      duration: Duration(milliseconds: 3000),
      backgroundColor: Colors.indigo,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
