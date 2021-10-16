import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_model.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/providers/database_provider.dart';

class NewItemPage extends StatefulWidget {
  NewItemPage({Key key}) : super(key: key);

  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final formKey = GlobalKey<FormState>();
  final createArticle = ProductosProvider();
  ListaMandado producto = ListaMandado();
  int _basicsValue = 0;
  String _nameValue = '';
  double _precioValue = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DBProvider.db.getListLenght();
    // print(createArticle.categorias[_categoria]);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Agrega un nuevo artículo',
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
              // padding: EdgeInsets.all(15),
              child: _imagen(context, 'Otros'),
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
                  width: size.width * 0.4,
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
        labelText: 'Nombre del artículo',
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
              'Agregar Artículo',
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

  void _submit() {
    ListaMandado element = ListaMandado();
    element.nombre = _nameValue;
    element.basics = 0;
    element.precio = 0;
    element.categoria = 'Otros';
    listaGlobal.add(element);

    // if (!formKey.currentState.validate()) return;
    // formKey.currentState.save();
    print(element);
    Navigator.pushNamed(context, 'list');
    // .then((value) => setState(() {}));
    setState(() {
      FocusScope.of(context).unfocus();
      // mostrarSnackBar('¡Guardado!');
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
