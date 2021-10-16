import 'package:flutter/material.dart';

class Categoria extends StatelessWidget {
  final String icono;
  final String departamento;
  const Categoria(this.icono, this.departamento);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color.fromRGBO(181, 196, 196, 1.0),
        height: size.height * 0.165,
        width: size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
                image: AssetImage('assets/$icono'),
                width: 60,
                height: 60,
                color: Colors.grey[700]),
            Text(
              departamento,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
