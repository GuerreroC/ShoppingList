import 'package:flutter/material.dart';
import 'package:shopping_list/providers/backend_provider.dart';
import 'package:shopping_list/widgets/categoria.dart';

class NewProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final producto = ProductosProvider();
    final _producto = producto.categorias;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: size.height * 0.1,
        title: Text(
          'Escoge la categoria',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[300],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: size.height * 0.9,
          color: Colors.grey[300],
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
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Frutas y Verduras');
                        },
                      ),
                      GestureDetector(
                        child: Categoria(
                            '${_producto['Abarrotes']}.png', 'Abarrotes'),
                        onTap: () {
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Abarrotes');
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
                            '${_producto['Carnes Frias']}.png', 'Carnes Frias'),
                        onTap: () {
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Carnes Frias');
                        },
                      ),
                      GestureDetector(
                        child: Categoria('${_producto['Aseo Personal']}.png',
                            'Aseo Personal'),
                        onTap: () {
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Aseo Personal');
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
                            Categoria('${_producto['Cocina']}.png', 'Cocina'),
                        onTap: () {
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Cocina');
                        },
                      ),
                      GestureDetector(
                        child: Categoria('${_producto['Baño']}.png', 'Baño'),
                        onTap: () {
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Baño');
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
                        child: Categoria('${_producto['Hogar']}.png', 'Hogar'),
                        onTap: () {
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Hogar');
                        },
                      ),
                      GestureDetector(
                        child: Categoria('${_producto['Otros']}.png', 'Otro'),
                        onTap: () {
                          Navigator.pushNamed(context, 'productDetails',
                              arguments: 'Otros');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
