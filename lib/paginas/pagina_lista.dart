import 'package:crud_flutter_victor_donghu/db/operaciones.dart';
import 'package:crud_flutter_victor_donghu/paginas/guardar_pagina.dart';
import 'package:crud_flutter_victor_donghu/paginas/actualizar_pagina.dart';

import 'package:flutter/material.dart';
import 'package:crud_flutter_victor_donghu/modelos/notas.dart';

class ListPages extends StatelessWidget {
  const ListPages({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton( //Boton flotante
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => guardarPagina())
          ); //Navegar a la pagina de guardar
      }),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('CRUD', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: _MiLista() 
      ),
    );
  }
}



class _MiLista extends StatefulWidget { 
  // const _MiLista({
  //   super.key,
  // });

  @override
  State<_MiLista> createState() => _MiListaState();

}
class _MiListaState extends State<_MiLista> { 
  List<Nota> notas = []; //Lista de notas

  @override
  void initState() {  //Se ejecuta antes de que se construya el widget
    _cargarDatos(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(  //Constructor de lista
      itemCount: notas.length,
      itemBuilder: (_, i) => _crearTEm(i), //Funcion que crea los elementos de la lista
    );
  }

  _cargarDatos() async { //Funcion para cargar las notas
    List<Nota> auxNotas = await Operaciones.obtenerNotas();
    setState(() {
      notas = auxNotas;
    });
  }

  _crearTEm(int i) { //Funcion para crear los elementos de la lista
    return Dismissible( //Widget para eliminar elementos de la lista
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white, size: 30,),
        ),
      ),
      onDismissed: (direction) {
        Operaciones.eliminarOperacion(notas[i]); //Eliminar la nota
        setState(() {
          notas.removeAt(i); // Eliminar la nota de la lista
        });
      },
      child: ListTile( 
        title: Text(notas[i].titulo), //Titulo de la nota
        trailing: IconButton( // Icono de lápiz para actualizar la nota
          icon: Icon(Icons.edit),
          onPressed: () {
            Operaciones.actualizarOperacion(notas[i]);
          },
        ),
      ),
    );
  }

 
}
