// To parse this JSON data, do
//
//     final listaMandado = listaMandadoFromJson(jsonString);

import 'dart:convert';

ListaMandado listaMandadoFromJson(String str) =>
    ListaMandado.fromJson(json.decode(str));

String listaMandadoToJson(ListaMandado data) => json.encode(data.toJson());

class ListaMandado {
  ListaMandado(
      {this.nombre, this.id, this.basics, this.precio, this.categoria});

  String nombre;
  int id;
  int basics;
  double precio;
  String categoria;

  factory ListaMandado.fromJson(Map<String, dynamic> json) => ListaMandado(
      nombre: json["nombre"],
      id: json["id"],
      basics: json["basics"],
      precio: json["precio"],
      categoria: json["categoria"]);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "id": id,
        "basics": basics,
        "precio": precio,
        "categoria": categoria
      };
}
