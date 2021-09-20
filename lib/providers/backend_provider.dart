import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/list_model.dart';
import 'package:shopping_list/providers/links.dart';

class ProductosProvider {
  Map categorias = {
    'Frutas y Verduras': 'frutas',
    'Carnes Frias': 'carnes_frias',
    'Abarrotes': 'abarrotes',
    'Aseo Personal': 'skincare',
    'Baño': 'bano',
    'Cocina': 'cocina',
    'Hogar': 'hogar',
    'Otros': 'carro_vacio',
  };

  Future<dynamic> crearProducto(ListaMandado producto, String categoria) async {
    final url = Uri.parse('${links['db']}/$categoria.json');
    print(url);
    final resp = await http.post(url, body: listaMandadoToJson(producto));
    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<List<ListaMandado>> cargarProductos(
      BuildContext context, String categoria) async {
    final url = Uri.parse('${links['db']}/$categoria.json');
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    // print(decodedData);
    final List<ListaMandado> productos = [];
    if (decodedData == null) return [];
    // La funcion .forEach es una iteracion para comnvertir el Map en una lista
    decodedData.forEach(
      (key, productoMap) {
        productoMap['precio'] = double.parse(productoMap['precio'].toString());
        final temp = ListaMandado.fromJson(productoMap);
        productos.add(temp);
      },
    );
    // print(productos[0].nombre);
    return productos;
  }

  Future<Map<String, Object>> cargarProductosRAW(BuildContext context) async {
    final url = Uri.parse('${links['db']}/.json');
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    Map<String, Object> listado = {};
    if (decodedData == null) return {};
    listado = decodedData;
    return listado;
  }
}
